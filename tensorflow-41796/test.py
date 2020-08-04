
from tensorflow.keras.layers import Input, Conv2D, Conv2DTranspose, Dense, Flatten
from tensorflow.keras.models import Model

def dump_model( model, indent=0 ):
    print( '-'*indent, model.name, ('None-Trainable', 'Trainable')[model.trainable] )
    if hasattr(model, 'layers'):
        for layer in model.layers:
            dump_model( layer, indent+2 )

def build_critic():
    input = Input( shape=(28, 28, 1 ) )
    output = Dense(1)(Flatten()(input))
    return Model( input, output )

def generator():
    input = Input( shape=(28, 28, 1 ) )
    output = Conv2D( 1, (3, 3), padding='same' )(input)
    model = Model( input, output )
    model.compile( loss='mae', optimizer='adam' )
    return model

def build_mnist( optimizer = None ):
    input_shape = ( 28, 28, 1 )
    g_m2h = generator()
    g_h2m = generator()
    g_h2r = generator()
    g_r2h = generator()

    m_inputs = Input( shape=input_shape )
    m_output_1 = g_h2m( g_m2h( m_inputs ) )
    m_output_2 = g_h2m( g_r2h( g_h2r( g_m2h( m_inputs ) ) ) )

    r_inputs = Input( shape=input_shape )
    r_output_1 = g_h2r( g_r2h( r_inputs ) )
    r_output_2 = g_h2r( g_m2h (g_h2m( g_r2h( r_inputs ) ) ) )

    mh = g_m2h( m_inputs )
    mmh = g_r2h( g_h2r( mh ) )

    rh = g_r2h( r_inputs )
    rrh = g_m2h( g_h2m( rh ) )

    model_cycle = Model( inputs=[m_inputs, r_inputs], outputs=[m_output_1, m_output_2, r_output_1, r_output_2, mmh, rrh] )
    model_cycle.compile( loss='mae', optimizer='adam' )

    g_m2h.trainable = False
    g_h2m.trainable = False
    g_h2r.trainable = False
    g_r2h.trainable = False
    m_inputs = Input( shape=input_shape )
    g_m2r = g_h2r( g_m2h( m_inputs ) )
    model_m2r = Model( m_inputs, g_m2r, trainable=False )
    model_m2r.compile( loss='mae', optimizer='adam' ) # must compile here?

    critic_r = build_critic()
    critic = critic_r
    generator_model = model_m2r
    real_image = Input(shape=input_shape)
    valid = critic( real_image )
    noisy_image = Input(shape=input_shape)
    fake_image = generator_model(noisy_image)
    fake = critic( fake_image )
    critic_model = Model(inputs=[real_image, noisy_image], outputs=[valid, fake] )
    critic_model.compile(loss='mae', optimizer='adam' )
    model_wgan_r = critic_model
    model_wgan_r.summary()
    dump_model( model_wgan_r )

    r_inputs = Input( shape=input_shape )
    g_r2m = g_h2m( g_r2h( r_inputs ) )
    model_r2m = Model( r_inputs, g_r2m, trainable = False )
    model_r2m.compile( loss='mae', optimizer='adam' )

    critic_m = build_critic()
    critic = critic_m
    generator_model = model_r2m
    generator_model.Trainable = False
    real_image = Input(shape=input_shape)
    valid = critic( real_image )
    noisy_image = Input(shape=input_shape)
    fake_image = generator_model(noisy_image)
    fake = critic( fake_image )
    critic_model = Model(inputs=[real_image, noisy_image], outputs=[valid, fake] )
    critic_model.compile(loss='mae', optimizer='adam' )
    model_wgan_m = critic_model

    g_m2h.trainable = True
    g_h2m.trainable = True
    g_h2r.trainable = True
    g_r2h.trainable = True

    critic_r.trainable = False
    m_inputs = Input( shape=input_shape )
    m2r_critic = critic_r( g_h2r( g_m2h( m_inputs ) ) )
    model_critic_m2r = Model( m_inputs, m2r_critic  )
    model_critic_m2r.compile( loss='mae', optimizer='adam' )

    critic_m.trainable = False
    r_inputs = Input( shape=input_shape )
    r2m_critic = critic_m( g_h2m( g_r2h( r_inputs ) ) )
    model_critic_r2m = Model( r_inputs, r2m_critic )
    model_critic_r2m.compile( loss='mae', optimizer='adam' )

    print( '\n', '*'*80, '\n' )

    model_wgan_r.summary()
    dump_model( model_wgan_r )

    return model_cycle, model_wgan_r, model_wgan_m, model_critic_m2r, model_critic_r2m, model_m2r, model_r2m

if __name__ == "__main__":
    model_cycle, model_wgan_r, model_wgan_m, model_critic_m2r, model_critic_r2m, model_m2r, model_r2m = build_mnist()
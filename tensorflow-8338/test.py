import tensorflow as tf
mu = [1, 2, 3.]
diag_stdev = [4, 5, 6.]
dist = tf.contrib.distributions.MultivariateNormalDiag(mu, diag_stdev)
sess = tf.InteractiveSession()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
dist.sample().eval()
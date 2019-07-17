import unittest                               
import tensorflow as tf                       
                                              
class SomeTestClass(unittest.TestCase): 
    """Some docstring."""              
                                              
    def test_something(self):          
        print("Testing something...\n")
        print tf.contrib.rnn.LSTMCell         
        session = tf.Session()                
        session.close()         
import os,sys
import optparse

sys.path.append('/usr/lib/python2.7/dist-packages')
sys.dont_write_bytecode = True

import bm_ai
import bm_call_simple
import bm_nbody
#import bm_pickle
import bm_regex_effbot
import bm_regex_v8
import bm_richards
import bm_unpack_sequence

if __name__ == "__main__":
    parser = optparse.OptionParser()
    parser.add_option("-n", action="store", type="int", default=20,
                dest="num", help="Number of times to run the test.")
    options, args = parser.parse_args()

for i in range(options.num):
    bm_ai.bench(["-n", "1"])
    bm_call_simple.bench(["-n", "1"])
    bm_nbody.bench(["-n", "1"])
#    bm_pickle.bench(["pickle", "-n", "1"])
#    bm_pickle.bench(["unpickle", "-n", "1"])
    bm_regex_effbot.bench(["-n", "1"])
    bm_regex_v8.bench(["-n", "1"])
    bm_richards.bench(["-n", "1"])
    bm_unpack_sequence.bench(["-n", "1"])

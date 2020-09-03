#!/usr/bin/env python

"""Utility code for benchmark scripts."""
from __future__ import division, print_function

__author__ = "collinwinter@google.com (Collin Winter)"

import math
import operator


def run_benchmark(options, num_runs, bench_func, *args):
    """Run the given benchmark, print results to stdout."""
    data = bench_func(num_runs, *args)
    product = reduce(operator.mul, data, 1)


def add_standard_options_to(parser):
    """Add a bunch of common command-line flags to an existing OptionParser.

    This function operates on `parser` in-place.

    Args:
        parser: optparse.OptionParser instance.
    """
    parser.add_option("-n", action="store", type="int", default=100,
                      dest="num_runs", help="Number of times to run the test.")
    parser.add_option("--profile", action="store_true",
                      help="Run the benchmark through cProfile.")
    parser.add_option("--profile_sort", action="store", type="str",
                      default="time", help="Column to sort cProfile output by.")
    parser.add_option("--take_geo_mean", action="store_true",
                      help="Return the geo mean, rather than individual data.")

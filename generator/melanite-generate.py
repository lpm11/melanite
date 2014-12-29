# -*- coding: utf-8 -*-
import sys;
import math;
from colormath.color_objects import *;
from colormath.color_conversions import convert_color;
import argparse;


BASE_COLOR_NAMES = [
    "bg1",
    "bg2",
    "fgb",
    "fga",
    "fg1",
    "fg2",
];
BASE_COLOR_LIGHTS = [
    15,
    30,
    45,
    50,
    80,
    90,
];
BASE_COLOR_AS = [
    -2,
    -2,
    -1,
    -1,
    -1,
    -1,
]
BASE_COLOR_BS = [
    -2,
    -2,
    -1,
    -1,
    -1,
    -1,
]

ACCENT_COLOR_NAMES = [
    "red",
    "orange",
    "yellow",
    "green",
    "cyan",
    "blue",
    "purple",
    "violet",
];
ACCENT_COLOR_CHROMAS = [
    65,
    80,
    80,
    55,
    45,
    25,
    45,
    55,
];
ACCENT_COLOR_HUES = [
    5,
    65,
    95,
    125,
    185,
    245,
    305,
    335,
]


def p2r(r, degree):
    theta = math.pi * degree / 180;
    return ( r * math.cos(theta), r * math.sin(theta) );

def r2p(x, y):
    r = 180.0 * math.atan2(y, x) / math.pi;
    if (r < 0):
        r += 360;
    return ( math.hypot(x, y), r );

def clamp(color):
    return sRGBColor(color.clamped_rgb_r, color.clamped_rgb_g, color.clamped_rgb_b);


def main():
    parser = argparse.ArgumentParser(description="melanite color scheme generator");
    parser.add_argument("--lab-observer", metavar="N", default="2");
    parser.add_argument("--lab-illuminant", metavar="N", default="d50");
    for ci, cname in enumerate(BASE_COLOR_NAMES):
        parser.add_argument("--{}-l".format(cname), metavar="LIGHT", type=int,
                            help="Light for {}".format(cname), default=BASE_COLOR_LIGHTS[ci]);
        parser.add_argument("--{}-a".format(cname), metavar="A", type=int,
                            help="a* for {}".format(cname), default=BASE_COLOR_AS[ci]);
        parser.add_argument("--{}-b".format(cname), metavar="B", type=int,
                            help="b* for {}".format(cname), default=BASE_COLOR_BS[ci]);
    for ci, cname in enumerate(ACCENT_COLOR_NAMES):
        parser.add_argument("--{}-c".format(cname), metavar="CHROMA", type=int,
                            help="Saturation for {}".format(cname), default=ACCENT_COLOR_CHROMAS[ci]);
        parser.add_argument("--{}-h".format(cname), metavar="HUE", type=int,
                            help="Hue for {}".format(cname), default=ACCENT_COLOR_HUES[ci]);
    opt = parser.parse_args();
    opt_h = vars(opt);

    def lab2rgbhex(l, a, b):
        return clamp(convert_color(LabColor(l, a, b, observer=opt.lab_observer, illuminant=opt.lab_illuminant), sRGBColor)).get_rgb_hex();

    def lch2rgbhex(l, c, h):
        return lab2rgbhex(l, *p2r(c, h));

    # base
    for ci, cname in enumerate(BASE_COLOR_NAMES):
        rgbhex = lab2rgbhex(opt_h[cname+"_l"], opt_h[cname+"_a"], opt_h[cname+"_b"]);
        print("{}\t{}".format(cname, rgbhex));

    # default L*
    for ci, cname in enumerate(ACCENT_COLOR_NAMES):
        rgbhex = lch2rgbhex(70, opt_h[cname+"_c"], opt_h[cname+"_h"]);
        print("{}\t{}".format(cname, rgbhex));

    # various L*
    for l in range(0, 101, 5):
        # various gray L*
        rgbhex = lch2rgbhex(l, 0, 0);
        print("gray-l{}\t{}".format(l, rgbhex));

        for ci, cname in enumerate(ACCENT_COLOR_NAMES):
            rgbhex = lch2rgbhex(l, opt_h[cname+"_c"], opt_h[cname+"_h"]);
            print("{}-l{}\t{}".format(cname, l, rgbhex));

    sys.exit(0);

if (__name__=="__main__"):
    main();

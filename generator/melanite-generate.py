# -*- coding: utf-8 -*-
import sys;
import math;
from colormath.color_objects import *;
from colormath.color_conversions import convert_color;
import argparse;

BG_COLOR_A = -2;
BG_COLOR_B = -2;
FG_COLOR_A = -1;
FG_COLOR_B = -1;

BG_COLOR_NAMES = [
    "bg1",
    "bg2",
];
FG_COLOR_NAMES = [
    "fgb",
    "fga",
    "fg1",
    "fg2",
];
FG_COLOR_LIGHTS = [
    45,
    50,
    80,
    90,
];
BG_COLOR_LIGHTS = [
    15,
    30,
];

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

    parser.add_argument("--bg-a", metavar="A", type=int, help="a* for background", default=BG_COLOR_A);
    parser.add_argument("--bg-b", metavar="B", type=int, help="b* for background", default=BG_COLOR_A);
    parser.add_argument("--fg-a", metavar="A", type=int, help="a* for foreground", default=FG_COLOR_A);
    parser.add_argument("--fg-b", metavar="B", type=int, help="b* for foreground", default=FG_COLOR_A);
    for bi, base_color_names in enumerate([ BG_COLOR_NAMES, FG_COLOR_NAMES ]):
        base_color_lights = [ BG_COLOR_LIGHTS, FG_COLOR_LIGHTS ][bi];
        for ci, cname in enumerate(base_color_names):
            parser.add_argument("--{}-l".format(cname), metavar="LIGHT", type=int,
                                help="Light for {}".format(cname), default=base_color_lights[ci]);
            parser.add_argument("--{}-a".format(cname), metavar="A", type=int,
                                help="a* for {}".format(cname));
            parser.add_argument("--{}-b".format(cname), metavar="B", type=int,
                                help="b* for {}".format(cname));
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

    # background
    for ci, cname in enumerate(BG_COLOR_NAMES):
        rgbhex = lab2rgbhex(opt_h[cname+"_l"], (opt_h[cname+"_a"] or opt.bg_a), (opt_h[cname+"_b"] or opt.bg_b));
        print("{}\t{}".format(cname, rgbhex));

    # foreground
    for ci, cname in enumerate(FG_COLOR_NAMES):
        rgbhex = lab2rgbhex(opt_h[cname+"_l"], (opt_h[cname+"_a"] or opt.fg_a), (opt_h[cname+"_b"] or opt.fg_b));
        print("{}\t{}".format(cname, rgbhex));

    # accent
    for ci, cname in enumerate(ACCENT_COLOR_NAMES):
        rgbhex = lch2rgbhex(70, opt_h[cname+"_c"], opt_h[cname+"_h"]);
        print("{}\t{}".format(cname, rgbhex));

    # various L*
    lights = list(range(0, 101, 5));
    # more fine values for higher L*
    lights += list(range(90, 101, 1));

    for l in sorted(set(lights)):
        # various fg, bg, gray
        rgbhex = lab2rgbhex(l, opt.fg_a, opt.fg_b);
        print("fg-l{}\t{}".format(l, rgbhex));
        rgbhex = lab2rgbhex(l, opt.bg_a, opt.bg_b);
        print("bg-l{}\t{}".format(l, rgbhex));
        rgbhex = lch2rgbhex(l, 0, 0);
        print("gray-l{}\t{}".format(l, rgbhex));

        for ci, cname in enumerate(ACCENT_COLOR_NAMES):
            rgbhex = lch2rgbhex(l, opt_h[cname+"_c"], opt_h[cname+"_h"]);
            print("{}-l{}\t{}".format(cname, l, rgbhex));

    sys.exit(0);

if (__name__=="__main__"):
    main();

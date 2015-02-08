# -*- coding: utf-8 -*-
import sys;
import re;
import math;
import argparse;
from colormath.color_objects import *;
from colormath.color_conversions import convert_color;
from x256 import x256;

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
BG_COLOR_LIGHTS = [
    15,
    30,
];
FG_COLOR_LIGHTS = [
    45,
    50,
    80,
    90,
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
ACCENT_COLOR_LIGHT = 70;
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
];

SPECIAL_COLOR_NAMES = [
    "bg",
    "fg",
    "gray",
]
SPECIAL_COLOR_AS = [
    BG_COLOR_A,
    FG_COLOR_A,
    0,
]
SPECIAL_COLOR_BS = [
    BG_COLOR_B,
    FG_COLOR_B,
    0,
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
    parser = argparse.ArgumentParser(description="melanite color scheme generator / applier");

    # Mode
    parser.add_argument("--mode", choices=[ "preview", "tsv" ]);

    # Mode specific options
    parser.add_argument("--prefix", metavar="STR", help="prefix for replacement (@melanite-)", default=r"@melanite-");

    # CIE Lab general settings
    parser.add_argument("--lab-observer", metavar="N", default="2");
    parser.add_argument("--lab-illuminant", metavar="N", default="d50");

    # color specification
    parser.add_argument("--bg-a", metavar="A", type=int, help="a* for background", default=BG_COLOR_A);
    parser.add_argument("--bg-b", metavar="B", type=int, help="b* for background", default=BG_COLOR_A);
    parser.add_argument("--fg-a", metavar="A", type=int, help="a* for foreground", default=FG_COLOR_A);
    parser.add_argument("--fg-b", metavar="B", type=int, help="b* for foreground", default=FG_COLOR_A);
    for bi, base_color_names in enumerate([ BG_COLOR_NAMES, FG_COLOR_NAMES ]):
        base_color_lights = [ BG_COLOR_LIGHTS, FG_COLOR_LIGHTS ][bi];
        for ci, cname in enumerate(base_color_names):
            parser.add_argument("--{}-l".format(cname), metavar="LIGHT", type=int,
                                help="Default light for {}".format(cname), default=base_color_lights[ci]);
            parser.add_argument("--{}-a".format(cname), metavar="A", type=int,
                                help="a* for {}".format(cname));
            parser.add_argument("--{}-b".format(cname), metavar="B", type=int,
                                help="b* for {}".format(cname));
    parser.add_argument("--accent-l", metavar="LIGHT", type=int,
                        help="Default light for accent colors", default=ACCENT_COLOR_LIGHT);
    for ci, cname in enumerate(ACCENT_COLOR_NAMES):
        parser.add_argument("--{}-l".format(cname), metavar="LIGHT", type=int,
                            help="Default light for {}".format(cname), default=ACCENT_COLOR_LIGHT);
        parser.add_argument("--{}-c".format(cname), metavar="CHROMA", type=int,
                            help="Saturation for {}".format(cname), default=ACCENT_COLOR_CHROMAS[ci]);
        parser.add_argument("--{}-h".format(cname), metavar="HUE", type=int,
                            help="Hue for {}".format(cname), default=ACCENT_COLOR_HUES[ci]);

    # color modification (for applier)
    parser.add_argument("--lighten-accent", metavar="L", type=int, help="Lighten accent colors", default=0);
    for cname in (BG_COLOR_NAMES + FG_COLOR_NAMES + ACCENT_COLOR_NAMES + SPECIAL_COLOR_NAMES):
        parser.add_argument("--lighten-{}".format(cname), metavar="L", type=int,
                            help="Lighten {}".format(cname));

    opt = parser.parse_args();
    opt_h = vars(opt);

    def lab2color(l, a, b):
        return clamp(convert_color(LabColor(l, a, b, observer=opt.lab_observer, illuminant=opt.lab_illuminant), sRGBColor));

    def lch2color(l, c, h):
        return lab2color(l, *p2r(c, h));

    def get_light(cname):
        if (opt_h[cname+"_l"] is not None):
            return opt_h[cname+"_l"];
        raise ValueError("Invalid color: {}".format(cname));

    def get_lighten(cname):
        if (opt_h["lighten_"+cname] is not None):
            return opt_h["lighten_"+cname];
        elif (cname in ACCENT_COLOR_NAMES):
            return opt.lighten_accent;
        elif ((cname in BG_COLOR_NAMES) or (cname in FG_COLOR_NAMES) or (cname in SPECIAL_COLOR_NAMES)):
            return 0;
        raise ValueError("Invalid color: {}".format(cname));

    def mklab_base(cname, l=None, lighten=0):
        if (cname in BG_COLOR_NAMES):
            l = (l if (l is not None) else get_light(cname)) + lighten;
            return ( l, (opt_h[cname+"_a"] or opt.bg_a), (opt_h[cname+"_b"] or opt.bg_b) );
        elif (cname in FG_COLOR_NAMES):
            l = (l if (l is not None) else get_light(cname)) + lighten;
            return ( l, (opt_h[cname+"_a"] or opt.fg_a), (opt_h[cname+"_b"] or opt.fg_b) );
        raise ValueError("Invalid color: {}".format(cname));

    def mklch_accent(cname, l=None, lighten=0):
        if (cname in ACCENT_COLOR_NAMES):
            l = (l if (l is not None) else get_light(cname)) + lighten;
            return ( l, opt_h[cname+"_c"], opt_h[cname+"_h"] );
        raise ValueError("Invalid color: {}".format(cname));

    def mklab_special(cname, l, lighten=0):
        if (cname in SPECIAL_COLOR_NAMES):
            i = SPECIAL_COLOR_NAMES.index(cname);
            return ( l + lighten, SPECIAL_COLOR_AS[i], SPECIAL_COLOR_BS[i] );
        raise ValueError("Invalid color: {}".format(cname));

    def mkcolor(cname, l=None):
        if ((cname in BG_COLOR_NAMES) or (cname in FG_COLOR_NAMES)):
            return lab2color(*mklab_base(cname, l, get_lighten(cname)));
        elif (cname in ACCENT_COLOR_NAMES):
            return lch2color(*mklch_accent(cname, l, get_lighten(cname)));
        elif (cname in SPECIAL_COLOR_NAMES):
            return lab2color(*mklab_special(cname, l, get_lighten(cname)));
        raise ValueError("Invalid color: {}".format(cname));

    if (opt.mode == "preview"):
        for cname in (BG_COLOR_NAMES + FG_COLOR_NAMES):
            l, a, b = mklab_base(cname, lighten=get_lighten(cname));
            color = lab2color(l, a, b);
            print("{:<8} {} {:>3} {:>3} {:>3}".format(cname, color.get_rgb_hex(), l, a, b));
        for cname in ACCENT_COLOR_NAMES:
            l, c, h = mklch_accent(cname, lighten=get_lighten(cname));
            a, b = map(int, p2r(c, h));
            color = lch2color(l, c, h);
            print("{:<8} {} {:>3} {:>3} {:>3} {:>3} {:>3} {:>3}".format(cname, color.get_rgb_hex(), l, c, h, l, a, b));
    elif (opt.mode == "tsv"):
        for cname in (BG_COLOR_NAMES + FG_COLOR_NAMES + ACCENT_COLOR_NAMES):
            color = mkcolor(cname);
            print("{}\t{}".format(cname, color.get_rgb_hex()));

        # various L*
        lights = list(range(0, 101, 5));
        # more fine values for higher L*
        lights += list(range(90, 101, 1));
        for l in sorted(set(lights)):
            for cname in (SPECIAL_COLOR_NAMES + ACCENT_COLOR_NAMES):
                color = mkcolor(cname, l);
                print("{}-l{}\t{}".format(cname, l, color.get_rgb_hex()));
    else:
        def substitute_color(match):
            cname = match.group(1);
            light = int(match.group(2)) if (match.group(2)) else None;
            suffix = match.group(3) or match.group(4) or match.group(5);

            color = mkcolor(cname, light);
            rgbhex = color.get_rgb_hex();
            r, g, b = color.get_upscaled_value_tuple();
            rf, gf, bf = color.get_value_tuple();

            if (suffix is None):
                return rgbhex;
            else:
                suffix_dict = {
                    "r": r,
                    "g": g,
                    "b": b,
                    "rf": rf,
                    "gf": gf,
                    "bf": bf,
                    "r%": rf*100,
                    "g%": gf*100,
                    "b%": bf*100,
                    "[]": "[ {}, {}, {} ]".format(r, g, b),
                    "p": x256.from_rgb(r, g, b),
                };
                return str(suffix_dict[suffix]);

        re_melanite = re.compile(re.escape(opt.prefix) + r"([\w]+)(?:-l(\d+))?(?:-([rgb](?:f|%))|(?:-(p))|(\[\]))?");
        for line in map(lambda line: line.rstrip("\n"), sys.stdin):
            line = re_melanite.sub(substitute_color, line);
            print(line);


if (__name__ == "__main__"):
    main();

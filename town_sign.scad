/*
 * Dansk Byskilt (Danish Town Sign)
 *
 * Copyright (c) 2020 Mathias V. Rasmussen
 * Released under the terms of the GPLv3 license.
 */

city_name = "Aarhus";

layer_height = 0.2;
layers = 24;

sign_height = layer_height * layers;
back_height = sign_height * 2/3;

width =  32 + 7 * max(7, len(city_name));
height = 40;

radius = 6.5;

// Font from http://ts.vejdirektoratet.dk
use <dvsp.ttf>

// Set fragment size to smoothen curves
$fs = 0.1;

module fillet (r, delta) {
    offset(r = r)
    offset(delta = delta ? delta : -r)
    children();
}

module sign_shape (inward = 0) {
    fillet(radius - inward, -radius)
    square([width, height], center=true);
}

// Back plate
color("white")
linear_extrude(back_height) {
    sign_shape();
}

// Sign
color("#222")
linear_extrude(sign_height) {
    // Border line
    thickness = 1.3;
    margin = 2.7;
    difference() {
        sign_shape(margin);
        sign_shape(margin + thickness);
    }

    // Text
    translate([0, 4])
    text(city_name, size = 8, font = "dvsp",
         halign = "center");

    // Houses
    spacing = 4;
    center = (30+36+18+spacing*2) / 2;
    fillet(0.25)
    scale(0.5)
    translate([-center, -28, 0])
    union() {
        polygon(points=house_points[0]);
        translate([30+spacing, 0]) {
            polygon(points=house_points[1]);
            translate([36+spacing, 0])
                polygon(points=house_points[2]);
        }
    }
}

house_points =
[ [
    [ 0,  0], [ 0,  8], [ 8, 16], [16,  8],
    [16,  5], [20,  5],
    [20, 12], [25, 30], [30, 12], [30,  0]
], [
    [ 0,  0], [ 0, 13], [ 3, 16], [17, 16], [20, 13],
    [20,  3], [24,  3],
    [24,  6], [30, 12], [36,  6], [36,  0]
], [
    [ 0,  0], [ 0, 15], [ 9, 24], [18, 15], [18,  0]
] ];

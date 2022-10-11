#![allow(warnings, unused)]

const ITER_LIMIT: i32 = 2000;

fn screen_to_complex_plane(i: i32, j: i32, w: i32, h: i32, x0: f64, y0: f64, x1: f64, y1: f64) -> (f64, f64) {
    let pd = (f64::from(h) / (y1 - y0)).abs();  // assuming height is always smaller than width
    let x = f64::from(i) / pd + x0;
    let y = f64::from(j) / -pd + y0;
    return (x, y);
}

fn pythagoras(a: f64, b: f64) -> f64 {
    return (a*a + b*b).sqrt();
}

fn burning_ship(x: f64, y: f64) -> i32 {
    let mut i: i32 = 0;
    let mut zx: f64 = 0.0;
    let mut zy: f64 = 0.0;
    let mut temp: f64 = 0.0;

    while (i < ITER_LIMIT) && (pythagoras(zx, zy) <= 2.0) {
        temp = zx*zx - zy*zy + x;
        zy = (2.0*zx*zy).abs() + y;
        zx = temp;
        i += 1;
    }

    return i;
}

fn burning_ship_fractal(width: i32, height: i32, x0: f64, y0: f64, x1: f64, y1: f64) -> Vec<i32> {
    let mut fractal = vec![0; (width * height) as usize];

    for j in 0..height {
        for i in 0..width {
            let (x, y) = screen_to_complex_plane(i, j, width, height, x0, y0, x1, y1);
            fractal[(i + width * j) as usize] = burning_ship(x, y);
        }
    }

    return fractal;
}

fn main() {
    let width = 1600;
    let height = 900;
    let x0 = f64::from(-width) * 4.0 / 2.0 / f64::from(height);
    let y0 = 2.0;
    let x1 = f64::from(width) * 4.0 / 2.0 / f64::from(height);
    let y1 = -2.0;
    let fractal = burning_ship_fractal(width, height, x0, y0, x1, y1);

    println!("P1 {} {}", width, height);
    for i in fractal {
        println!("{}", if i == ITER_LIMIT {
            1
        } else {
            0
        });
    }
}

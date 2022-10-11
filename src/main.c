#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define ITER_LIMIT 2000

typedef struct {
	double x;
	double y;
} COORD;

COORD screen_to_complex_plane(int i, int j, int width, int height, COORD p0, COORD p1) {
	COORD p;
	double pd = height / fabs(p1.y - p0.y);  // assuming height is always smaller than width
	double x = i / pd + p0.x;
	double y = j / -pd + p0.y;

	p.x = x;
	p.y = y;

	return p;
}

double pythagoras(double a, double b) {
	return sqrt(a*a + b*b);
}

int burning_ship(COORD p) {
	int i = 0;
	double zx = 0.0;
	double zy = 0.0;
	double x = p.x;
	double y = p.y;
	double temp;

	while ((i < ITER_LIMIT) && (pythagoras(zx, zy) <= 2.0)) {
		temp = zx*zx - zy*zy + x;
		zy = fabs(2.0*zx*zy) + y;
		zx = temp;
		i++;
	}

	return i;
}

int* burning_ship_fractal(int width, int height, COORD p0, COORD p1) {
	int* fractal = (int*) malloc((width * height) * sizeof(int));
	int i, j;
 
	for (j = 0; j < height; j++) {
		for (i = 0; i < width; i++) {
			fractal[i + width * j] = burning_ship(screen_to_complex_plane(i, j, width, height, p0, p1));
		}
	}

	return fractal;
}

int main() {
	const int width = 1600;
	const int height = 900;
	const double x0 = -width * 4.0 / 2 / height;
	const double y0 = 2.0;
	const double x1 = width * 4.0 / 2 / height;
	const double y1 =-2.0;
	COORD p0;
	COORD p1;
	int* fractal = NULL;
	int i;

	p0.x = x0;
	p0.y = y0;
	p1.x = x1;
	p1.y = y1;
	fractal = burning_ship_fractal(width, height, p0, p1);

	printf("P1\n%d %d\n", width, height);
	for (i = 0; i < width * height; i++) {
		printf("%d ", ((fractal[i] == ITER_LIMIT)? 1 : 0));
	}
	printf("\n");

	free(fractal);
	return 0;
}

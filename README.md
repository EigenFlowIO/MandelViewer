# Mandelbrot Set Viewer

This project is an interactive Mandelbrot set visualizer built using Processing.js. It provides a simple interface for exploring the complex structure of the Mandelbrot set through zooming, panning, and adjusting rendering detail. Designed with an emphasis on interactivity and computational aesthetics, this tool offers both a visual and mathematical exploration of one of the most well-known fractals in mathematics.

## Features

- **Dynamic Rendering**: Colorful visual output based on variable escape-time algorithm with smooth hue transitions.
- **Zoom Controls**: Zoom in and out to explore intricate details of the Mandelbrot set.
- **Panning**: Navigate through the complex plane using directional controls.
- **Detail Adjustment**: Increase or decrease iteration depth to manually balance zoom, rendering speed, and visual detail.
- **Click-to-Center**: Click anywhere on the canvas to re-center the view on that point.
- **Performance Optimization**: Iteration count adapts based on distance from center, optimizing detail at the center of the image where it matters most.

## How It Works

Each pixel corresponds to a complex number. The viewer calculates whether that number belongs to the Mandelbrot set using the classic escape-time algorithm. Points that remain bounded after a certain number of iterations are rendered in black; those that diverge are colored according to how quickly they escape.

## Controls

| Control         | Description                                 |
|----------------|---------------------------------------------|
| Zoom In        | Increases zoom level (1.5x per click)       |
| Zoom Out       | Decreases zoom level                        |
| ↑ / ↓ / ← / →  | Pans the view in the corresponding direction|
| More Detail    | Increases iteration count by 10%            |
| Less Detail    | Decreases iteration count by 10%            |
| Mouse Click    | Re-centers the view on the clicked point    |

## Example Projects Inspired by This Tool

- Interactive fractal zoom explorers
- Teaching tools for complex numbers and iterative algorithms
- Visual introductions to chaos and fractal geometry

## Potential Extensions

- Save and load custom views
- Export high-resolution images
- Add animation or zoom history playback
- Integrate performance profiling tools for real-time optimization

## Getting Started

1. Open the project in a Processing.js-compatible environment.
2. Run the sketch.
3. Use the on-screen controls or click to explore the Mandelbrot set interactively.

## License

This project is open-source and available for educational and personal use.

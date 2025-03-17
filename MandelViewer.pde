Here is the mandelbrot tool. Interpret the code:

//Begin Sketch Code
float zoom = 1;
float centerX = 0;
float centerY = 0;
float iterationScaleFactor = 1.0;
float centerPhase = 0;
GUI gui;
int virtualWidth = 800;
int virtualHeight = 800;


void setup() {
    size(600, 600);
    colorMode(HSB, 255);
    gui = new GUI();
    
    // Zoom buttons
    gui.addButton(10, 10, 60, 20, "Zoom In", () -> zoom *= 1.5);  // Made smaller
    gui.addButton(80, 10, 60, 20, "Zoom Out", () -> zoom /= 1.5);  // Made smaller and moved to the right

    // Center control buttons, moved up and to the right, and made smaller
    gui.addButton(500, 10, 20, 20, "^", () -> centerY -= height / (1028.0 * zoom));  // Up
    gui.addButton(500, 40, 20, 20, "v", () -> centerY += height / (1028.0 * zoom));  // Down
    gui.addButton(475, 25, 20, 20, "<", () -> centerX -= width / (1028.0 * zoom));  // Left
    gui.addButton(525, 25, 20, 20, ">", () -> centerX += width / (1028.0 * zoom));  // Right
    gui.addButton(150, 10, 120, 20, "More Detail", () -> iterationScaleFactor *= 1.1);  // Increase iterations by 10%
    gui.addButton(280, 10, 120, 20, "Less Detail", () -> iterationScaleFactor = max(1, (int)(iterationScaleFactor * 0.9)));  // Decrease iterations by 10%
}


void draw() {
    loadPixels();
    for (int px = 0; px < width; px++) {
        for (int py = 0; py < height; py++) {
            double xNorm = map(px, 0, width, -2.5, 1.5);
            double yNorm = map(py, 0, height, -1.75, 1.75);
            double real = xNorm / zoom + centerX;
            double imag = yNorm / zoom + centerY;

            int iterations = round(iterationScaleFactor * calculateMaxIterations(px, py)); // Dynamic iterations based on position
            pixels[py * width + px] = mandelbrot(real, imag, iterations); // Pass iterations as an argument
        }
    }
    updatePixels();
    gui.displayGUI();
}


void mousePressed() {
    boolean buttonClicked = gui.checkClick();
    
    // Only change the center if no GUI button was clicked
    if (!buttonClicked) {
        float newCenterX = map(mouseX, 0, width, centerX - 2.5 / zoom, centerX + 1 / zoom);
        float newCenterY = map(mouseY, 0, height, centerY - 1.75 / zoom, centerY + 1.75 / zoom);

        centerX = newCenterX;
        centerY = newCenterY;
        centerPhase = atan2(centerY, centerX);

    }
}

int mandelbrot(double real, double imag, int maxIterations) {
    double zr = 0.0, zi = 0.0;
    int iteration = 0;

    for (iteration = 0; iteration < maxIterations; iteration++) {
        double temp = zr * zr - zi * zi + real;
        zi = 2 * zr * zi + imag;
        zr = temp;

        if (zr * zr + zi * zi > 4) {
            float hue = 255 * iteration / (float)maxIterations;
            return color(hue, 255, 255 - hue);
        }
    }

    return color(0); // Points within the set are colored black
}




class GUI {
    ArrayList<Button> buttons = new ArrayList<Button>();

    void addButton(float x, float y, float width, float height, String label, Runnable action) {
        Button newButton = new Button(x, y, width, height, label, action);
        buttons.add(newButton);
    }

    void displayGUI() {
        for (Button button : buttons) {
            button.display();
        }
    }
    
     boolean checkClick() {
        for (Button button : buttons) {
            if (button.isHovered() && mousePressed) {
                button.action.run();
                return true; // A button was clicked
            }
        }
        return false; // No button was clicked
    }
}

class Button {
    float x, y; // Button position
    float width, height; // Button dimensions
    String label; // Button text
    Runnable action; // Action to perform when button is clicked

    // Constructor
    Button(float x, float y, float width, float height, String label, Runnable action) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        this.label = label;
        this.action = action;
    }

    // Method to check if the mouse is over the button
    boolean isHovered() {
        return mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height;
    }

    // Display the button
    void display() {
        if (isHovered()) {
            fill(220); // Light grey if hovered
        } else {
            fill(255); // White otherwise
        }
        rect(x, y, width, height, 5); // Rounded corners
        fill(0); // Black text
        textAlign(CENTER, CENTER);
        text(label, x + width / 2, y + height / 2);
    }

    // Check if the button is clicked
    void checkClick() {
        if (isHovered() && mousePressed) {
            action.run();
        }
    }
}

int calculateMaxIterations(int x, int y) {
    float distFromCenter = dist(x, y, width / 2, height / 2);
    float maxDist = dist(0, 0, width / 2, height / 2);
    // Invert and scale the distance to get higher iterations closer to the center
    return (int) map(distFromCenter, 0, maxDist, 300, 100);
}


//End Sketch Code

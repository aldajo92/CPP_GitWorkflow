#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent), isVisible(true)
{
    // Create central widget and layout
    centralWidget = new QWidget(this);
    layout = new QVBoxLayout(centralWidget);
    
    // Create the "Hello World" label
    helloLabel = new QLabel("Hello, World!", this);
    helloLabel->setAlignment(Qt::AlignCenter);
    helloLabel->setStyleSheet("QLabel { font-size: 18px; color: blue; margin: 20px; }");
    
    // Create the toggle button
    toggleButton = new QPushButton("Hide Hello World", this);
    toggleButton->setStyleSheet("QPushButton { font-size: 14px; padding: 10px; }");
    
    // Add widgets to layout
    layout->addWidget(helloLabel);
    layout->addWidget(toggleButton);
    layout->setAlignment(Qt::AlignCenter);
    
    // Set central widget
    setCentralWidget(centralWidget);
    
    // Connect button click to toggle function
    connect(toggleButton, &QPushButton::clicked, this, &MainWindow::toggleHelloWorld);
    
    // Set window properties
    setWindowTitle("Qt Hello World Toggle");
    resize(300, 150);
}

MainWindow::~MainWindow()
{
}

void MainWindow::toggleHelloWorld()
{
    if (isVisible) {
        helloLabel->hide();
        toggleButton->setText("Show Hello World");
        isVisible = false;
    } else {
        helloLabel->show();
        toggleButton->setText("Hide Hello World");
        isVisible = true;
    }
}

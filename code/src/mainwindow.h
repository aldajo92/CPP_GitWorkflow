#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QPushButton>
#include <QLabel>
#include <QVBoxLayout>
#include <QWidget>

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

private slots:
    void toggleHelloWorld();

private:
    QPushButton *toggleButton;
    QLabel *helloLabel;
    QWidget *centralWidget;
    QVBoxLayout *layout;
    bool isVisible;
};

#endif // MAINWINDOW_H

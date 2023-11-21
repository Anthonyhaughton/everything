# import turtle
# timmy = turtle.Turtle()

# Or you can clean it up if you only need one thing from the turtle module and say:
from turtle import Turtle, Screen
timmy = Turtle()
print(timmy)

timmy.shape("turtle")
timmy.color("DarkRed")
timmy.forward(100)

my_screen = Screen()
# ".canvheight" is the attribute of the object Screen
print(my_screen.canvheight)

# the ".exitonclick()" is a method which I think is like a attribute as a func
my_screen.exitonclick()
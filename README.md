```
#    #
#   #    ##   #####  #####  ###### #    #   ##   #####
#  #    #  #  #    # #    # #      #   #   #  #  #    #
###    #    # #    # #    # #####  ####   #    # #    #
#  #   ###### #####  #####  #      #  #   ###### #####
#   #  #    # #      #   #  #      #   #  #    # #   #
#    # #    # #      #    # ###### #    # #    # #    #
```
# Kaprekar

A simple implementation of Kaprekar's routine in FLUTTER.

## What is Kaprekar's Routine?

6174 is one of those little numerical gremlins that mathematicians adore: Kaprekar’s constant.

Here’s the trick, this thing is like a mathematical gravity well. Any 4-digit number (with at least two distinct digits) gets sucked into 6174 by a simple ritual:
	1.	Take your number.
	2.	Arrange digits descending → call that D.
	3.	Arrange digits ascending → call that A.
	4.	Compute D – A.
	5.	Repeat.

No matter where you start, you fall into 6174 in at most 7 iterations. Once you land, it loops forever:

7641 – 1467 = 6174
7641 – 1467 = 6174 (yep, it stays)

A tiny deterministic attractor hiding in the bland land of 4-digit integers. Feels like the universe leaving Post-It notes behind saying “psst… chaos isn’t the boss here.”
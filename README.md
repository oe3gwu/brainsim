# Brainsim
Neural Network on a Commodore 64

*This was my most outrageous excursion into Commodore 64 programming. It's a complete neural network associative memory pattern recogniser implemented in fewer than 250 lines of BASIC. You can train the network on a variety of patterns (letters and numbers) and then recognise similar patterns. I submitted this (serially) to all of the Commodore magazines, each of which rejected it as “too esoteric”. I prefer to think of it as simply before its time.*

When you first start to learn about computers, it's only natural to compare how a computer “thinks” with how people do. As you learn more, you tend to stop making such comparisons because you come to realize that far from the literal, dumb servants they're often pictured as in movies, computers are completely different from people both in how they operate and the kinds of problems they can solve.

But it's still fascinating to compare a computer to a human brain. Researchers are beginning to discover principles which may explain how the brain works, and while much of this research is extremely complicated and requires large, expensive computers, your Commodore 64 can be programmed in BASIC to mimic one fundamental part of brain function, pattern recognition. In doing this, your computer is not only doing something the brain does (and your reaction may be “I didn't know a computer could do that!”), it's doing it the brain's way—by simulating the neurons (brain cells) with which you think. 

# Computer Storage and Human Memory
First, let's compare what the word “memory” means in a computer as opposed to a human being. A computer memory is really a huge collection of pigeonholes into which numbers are stuffed. If you want to store something that isn't a number, such a piece of text, a picture, or a sequence of musical notes, you first have to convert it to numbers, then put those numbers into the pigeonholes of the computer's memory. Machine language programming is just translating the instructions for solving a problem into numbers the computer can remember. A computer stores numbers. 

![grafik](https://github.com/user-attachments/assets/f10f6acc-d6d1-4dbd-a114-e6112fad439c)

Human memory is richer and much more complicated. What comes to mind when you look at the picture above? Even though this picture is nothing more than 63 straight black lines on a white piece of paper, your brain immediately recognizes it as a sleeping cat. You can even imagine how a real cat would look if seen from other angles. The human brain seems to store and recall patterns. These patterns don't have to be pictures. You can recall pieces of music from only a few notes of the melody, think of words that rhyme with “frog” or that end with “ple”, and quickly name the American presidents that have the same names as automobiles.

It isn't that human memory is better or worse than computer memory, but rather that they are entirely different things. Some computer scientists prefer the term “storage” to “memory” because it more accurately describes what the computer does. If you walk up to a computer and ask it “what is the name of the famous bridge in the same state as Disneyland” you won't have much success, but most people will immediately answer, “The Golden Gate Bridge”. On the other hand, if you try to memorize a list of 20,000 two digit numbers, you probably won't succeed, yet a Commodore 64 can do this in less than a second and not make a single mistake. That computer and human memory are so different isn't all that surprising when you consider how differently constructed are the brain and a computer. 

# What Brains Are Made Of

![grafik](https://github.com/user-attachments/assets/a4db7612-96e7-4ed1-a0bc-313d1f2911e9)

The portion of the brain believed responsible for thought and memory consists primarily of nerve cells, or neurons. Each neuron has three parts, dendrites, a cell body, and an axon. The dendrites connect to the axons of other neurons. When these other neurons are stimulated, the dendrites convey the signal to the cell body via a synapse or connection, which either excites or inhibits the neuron (with a different strength for each synapse). When the excitation sufficiently outweighs inhibition, the neuron “fires”. This sends a signal down its axon which in turn excites or inhibits other neurons, and perhaps causes a muscle to move. 

![grafik](https://github.com/user-attachments/assets/72485297-7cc5-4b1e-9f5d-8786a2c50025)

Because neurons primarily connect to other neurons they form networks of great complexity. Figure 3 shows two fields of five neurons each, in which each neuron connects to every neuron in the other field. In this simple case we have 10 neurons with 5 connections (or synapses) each, for a total of 50 synapses. Now consider the brain. Researchers believe that the brain contains between ten and a hundred billion neurons, each of which connects to anywhere from a thousand to a hundred thousand other neurons, forming at least ten trillion connections, and probably far more. Compare this to the read-write memory of the Commodore 64, which is made up of about a quarter million transistors, and remember that each transistor is only a switch—far simpler than a neuron. 

# The Brain Simulator

Ten billion neurons, ten trillion connections: does it make sense to talk about simulating the brain on a computer? Can we make a computer recognize patterns the way a brain does? Remarkably, we can. A simple program can simulate the behavior of a network of interconnected neurons. You can show this program patterns and it will remember them. Then if you show it a similar pattern, it will find the pattern it's learned that is most like the pattern it's shown. The technical name for this is an “associative memory”, so called because it recalls items based on similarity, like the brain, as opposed to location, like a computer.

The Brain Simulator is written in BASIC for the 64 and 128 (in 64 mode). When you've finished typing in the program, save a copy to tape or disk. To run the program, simply load it and type RUN. You'll see two blank windows on the screen. Below them is a legend that explains the action of the function keys. When you type a letter or number, the dot pattern for that symbol appears in the left window. Try typing a few letters and numbers to see how this works. When you start the program, it doesn't know any patterns—so we'll teach it some. To learn a pattern, place it in the left window by pressing the key for the letter or number and then press F1. The program trains its simulated neurons to memorize the pattern (this takes about 30 seconds). READY reappears on the screen when the pattern has been learned. Go ahead and teach the program three different-looking letters, “A”, “T”, and “Z”.

Now let's try recalling a pattern. Press the “A” key to place an A in the left window. Now press F3—this introduces errors in the pattern by randomly changing about 10% of the dots in the pattern each time you press it. After you press F3, you'll have a pattern that looks something like an A, but doesn't exactly match what we taught the program. Press F5 to start the recall process. The pattern is run back and forth through the neuron network until it stabilizes on a fixed pattern (an arrow in the middle of the screen shows the direction of the transfer). After the neuron network has “thought” about the problem for a few cycles, you'll probably get back the original A we taught the program (just like the brain, this process doesn't always remember the right thing; if the random changes made the pattern more like another pattern the program has learned, that one will be found instead).

Try entering T and Z, creating errors in them by pressing F3 one or two times, and recalling with F5. Note how the neuron network almost always recalls the correct pattern even though you've given it something quite different from what it learned. Enter “I” and try recalling with F5. The network recognizes this as T because I looks more like T than A or Z, the other patterns it has learned. This is what your brain does when it sees a pattern of lines and immediately thinks of a sleeping cat. Many researchers think the basic process the brain uses is much the same as the one used by this program.

You can make the program forget everything it has learned by pressing F4. If you press F6, the program exits to BASIC. When you leave the program everything it has learned is forgotten, but you can save learned patterns on the disk by pressing F7 and entering a file name. The next time you run the program you can reload the program's memory by pressing F8 and entering the same file name. 

# How it Works

The remarkable thing about this program is that it doesn't “know” it's recognizing letters and numbers. As far as the program is concerned, it could be learning phrases of music, combinations of medical symptoms, or pictures of animals.

The program simulates two fields of neurons with the arrays F1% and F2%, and displays these fields in the two windows on the screen. When you type a letter or number, the dot pattern for that symbol is read from the character ROM and stored in F1%. Lighted dots are stored as 1 and background dots as −1. The character patterns are 6 dots wide by 7 dots high, so F1% and F2% both hold 42 numbers.

Each neuron in a field potentially connects to every neuron in the other field. Each connection, which is equivalent to a synapse in the brain, has its own weight: positive to excite, negative to inhibit, and zero if there is no connection. These weights are stored in the 42×42 matrix M%, for a total of 1,764 connections. To learn a pattern, we form a matrix from the pattern in F1% and add it to the weight matrix M% (see lines 1020–1060 in the program). To recall a pattern we take the the pattern in F1% and multiply it by the weight matrix (lines 1410–1480). If the value is 1 or more, we place a 1 in that position of F2%; if it's negative, we store a −1 there. If the value is zero, we leave the value in F2% alone. Then we take the value in F2% and multiply it back through the the matrix, but swapping rows and columns, and store it back into F1% (lines 1540–1610). We keep this up until the pattern in F1% stops changing. That's our final value, the pattern we've recalled from the network. 

# Limits of Learning

The number of different patterns a neuron network can learn is determined by the number of neurons and connections. This very small network can learn only 2 or 3 distinct patterns before it begins to get confused. If you try to teach it 4 or 5 patterns, it will often recall the wrong pattern, or even a spurious pattern you never taught it. That's where the enormous complexity of the brain comes in; your brain has at least five billion times as many connections as this little program, so your ability to learn and remember is correspondingly greater.

But like a singing dog, it's not how well it sings but the fact it sings at all. With less than 250 lines of BASIC, we can make the Commodore 64 play the brain's game, pattern recognition, the brain's way, by simulating a neuron network. It can learn simply by being shown patterns and recall a similar pattern when shown something it's never seen before. Research into neuron networks is one of the most exciting and rapidly expanding fields in science today, bringing together computer science, psychology, mathematics, and biology to discover how the brain accomplishes the remarkable things it does. This research may lead to computers that can recognize faces, understand speech, and answer complicated questions. But more importantly, we may find answers to questions as old as mankind: “What is thought?”, “What is memory?”, and “How do people reason?”. That your home computer can help you understand and experiment with such matters is testimony to the power latent within it. 

# For Further Information

 This article only scratches the surface of the topic of neuron networks and associative memory. If you're interested in learning more, the following article and book are a good way to start.

    Kosko, B., “Constructing an Associative Memory”. Byte, September 1987.

    Rumelhart, A., and McClelland, J., eds., Parallel Distributed Processing (two volumes), MIT Press, 1986.

# Sample Output

![grafik](https://github.com/user-attachments/assets/6f0fe990-5758-4a16-b688-29cdaaa624fb)

*by John Walker
September, 1987
Web edition: April, 2008
Updated: October, 2017*

---
title: "Neural Style Transfer Explained"
date: 2018-04-29T10:20:35+05:30
draft: false
---

Welcome Everyone to the journey into Neural Style transfer. Let's dive. :smiley:

## Level one : Introduction
With the rise of Deep Learning technology people invented awesome things using this technology. Neural style transfer (aka Artistic style transfer) is one of the amazing works. It is introduced in 2015 by [Gatys et al](https://arxiv.org/abs/1508.06576). I'm not going to make you sleepy by discussing details in the paper at this level. Let's talk about the things can be done using the technology. I believe you all like to draw your painting in your favorite artist's style. It not an easy task if you do not have enough skills in painting. Don't worry, Deep Learning have power to [reincarnate](https://www.britannica.com/topic/reincarnation) your favorite artist and make him/her to draw your painting. Looking amazing right?. Let me show you an example. <br>

Here is your Image(In literature it is known as **Content Image**):

<p align="center">
<img src="/nn_style/nn_content.png" alt="Content Image" />
</p>

And this is your favorite artist's painting(Known as **Style Image**):

<p align="center">
<img src="/nn_style/nn_style.png" alt="Style Image">
</p>

> Now Let's do the Magic :sparkles:

This the Resulted image:

<p align="center">
<img src="/nn_style/nn_result.png" alt="Result Image">
</p>

Looking great right?. Let's move to the __level two__.

<br>
## Level two : Understanding Concepts

From this level onwards you need to have some understanding in **How Convolutional Neural Networks work**. If you dont have, Don't feel worry here are some resources to learn CNNs.

1. [Understanding CNN](https://cs231n.github.io/understanding-cnn/) (from cs231n)
1. [Convolutional Neural Networks](https://www.youtube.com/watch?v=FTr3n7uBIuE) (by Siraj Ravel)

For those who have understood CNN, follow me. Others, follow above links and See you in couple of days :wave:

In any Neural Network Based model there are three main components. Namely,

1. Data.
1. Network Architecture.
1. Loss Function.

Let's understand each components above and how they are related to our topic.
### **Data**
For this task we need three inputs. They are,

* Style Image (S_).
* Content Image (C_).
* Random Noise (G_).

Both Style Image, Content Image are explained in level one. I hope you understood. Let's talk about _Random Noise_. In simple words, this is the initialization of the final generated image.

<p align="center">
<img src="/nn_style/random_noise.png" alt="Random Noise">
</p>


### **Network architecture**

For this task we use pre-trained CNN such as VGG-16 / VGG-19.

<p align="center">
<img src="/nn_style/vgg-16.png" alt="Random Noise">
</p>

### **Loss Function**

The loss function for the whole operation is as follows,

<p align="center">
<img src="https://latex.codecogs.com/svg.latex?\Large&space; Loss(G)= \alpha*Loss(C,G) + \beta*Loss(S,G)" />
</p>

* _Loss(G)_ : Total Loss
* _Loss(C,G)_ : Content Loss 
* _Loss(S,G)_ : Style Loss
* _alpha_ and _beta_ are hyper parameters

In a simplified way, neural style transfer can be expressed in 2 lines of steps.

1. Initialize Generated Image(G) randomly (This is the noise image).
1. Use an optimizer to minimize _Loss(G)_ and update **G**

<p align="center">
<img src="https://latex.codecogs.com/svg.latex?\Large&space; G = G - \gamma * \frac{d}{d(G)}(Loss(G))" />
</p>

#### Content Loss

We will use layer[L] of the CNN to compute the content loss. The layer[L] should be taken layer neither too shallow nor too deep in the neural network. Now we feed both Content Image and Random Noise(Generated Image) into the CNN. We need to get activations of layer[L] for both Images. Let's say, <br>
**_a[C]_** is the activation of the Content Image and <br>
**_a[G]_** is the activation of the Generated Image at layer[L]

if the difference between _a[C]_ and _a[G]_ is smaller, we can say that both Images have similar content. The metric we use to measure the difference is RMSE.

<p align="center">
<img src="https://latex.codecogs.com/svg.latex?\Large&space; Loss(C,G) = || a[C] - a[G] ||_F^2" />
</p>

#### Style Loss

For Content Loss calculations we used only Layer[L]. <br>
But In Style Loss Calculation we use multiple layers. But for now we look at how to calculate Style Loss in one layer(Layer[L]).<br>
Like above, we need to feed both Style Image and Generated Image into our CNN and get their activations at the Layer[L]. Instead of calculating RMSE directly using those activations, we use something different in this case. That thing is, we are checking **how activations are correlated across different channels in Layer[L]**. In the literature it is known as _Gram Matrix_ or _Style Matrix_. We need to calculate Gram Matrix for both Style and Generated Image. Gram Matrix calculation of ith and jth position of channel k in the Layer[L] for style activations is as follows.

<p align="center">
<img src="https://latex.codecogs.com/svg.latex?\Large&space; G_{ij}^{[L][S]} = \sum_k a_{ik}^{[S]} . a_{jk}^{[S]}" />
</p>

i=(1 to nh), j=(1 to nw) and k=(1 to nc) <br>

After calculating Gram Matrix for both Style and Generated image, We use RMSE to calculate the difference at Layer[L]. It is similar what we do in Content Loss.

<p align="center">
<img src="https://latex.codecogs.com/svg.latex?\Large&space; Loss(S,G)^{[L]} = || G^{[S][L]} - G^{[G][L]} ||_F^2" />
</p>

For more visually pleasing results we combine style costs for different layers. 

<p align="center">
<img src="https://latex.codecogs.com/svg.latex?\Large&space; Loss(S,G) = \sum_l \lambda * Loss(S,G)^{[l]}" />
</p>

Layer l = [conv1, conv2, conv3 ..... ]

Now we can use following equation to calculate the Total Loss,

<p align="center">
<img src="https://latex.codecogs.com/svg.latex?\Large&space; Loss(G)= \alpha*Loss(C,G) + \beta*Loss(S,G)" />
</p>

Use your favorite optimizer to minimize the total loss and Update the Noise Image.

---------END--------

<br>
<br>
Thank you for coming this journey with me. See you in another post. Until then, Happy Learning!!
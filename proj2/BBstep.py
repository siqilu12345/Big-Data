import numpy as np
import matplotlib.pyplot as plt
from tensorflow.examples.tutorials.mnist import input_data
mnist = input_data.read_data_sets('/Users/siqilu/Documents/MNIST_data/',
                                 validation_size=0)
def error(train,lamb,w) :
    x=train[:,:-1]
    y=train[:,-1]
    err=0
    for i in range(np.size(y)) :
        err=err+np.log(1+np.exp(-y[i]*np.dot(w,x[i][:].T)))
    err=err+lamb*np.sum(np.abs(w))
    return err
def gradient(x,y,w,batch_size,lamb,N) :
    g=np.zeros(np.size(w))
    for i in range(np.size(w)):
        if w[i]>0 :
            g[i]=1*lamb*batch_size/N
        elif w[i]<0 :
            g[i]=-1*lamb*batch_size/N
        else :
            g[i]=np.random.uniform(-1,1)/batch_size
    for j in range(np.shape(x)[0]):
        g = g - y[j] * (x[j][:]).T * np.longfloat(
            np.exp(-y[j] * np.dot(w, x[j][:].T))) / (
            1 + np.longfloat(np.exp(-y[j] * np.dot(w, x[j][:].T))))
    return g
def bbstepiter(train,lamb,batch_size=50,maxiter=100) :
    w0 = np.ones(np.size(train[0][:]) - 1) / 1000
    w = w0
    N = np.size(train, axis=0)
    err = -np.ones(maxiter)
    tao=0.01
    for i in range(maxiter):
        np.random.shuffle(train)
        err[i] = error(train, lamb, w)
        batch = train[:batch_size, :]
        y = batch[:, -1]
        x = batch[:, :-1]
        g = gradient(x, y, w, batch_size, lamb, N)
        neww=w-tao*g
        s=-tao*g
        if np.max(np.abs(s))<10**(-7) :
            break
        ss=gradient(x, y, neww, batch_size, lamb, N)-g
        tao=np.dot(s,s)/np.dot(s,ss)
        w=neww
    return err
label=2*(mnist.train.labels.astype(int)%2)-1
label=np.reshape(label,(-1,1))
lamb=1/np.size(label,axis=0)
train=np.concatenate((mnist.train.images.astype(float),label),axis=1)
err=bbstepiter(train,lamb)
plt.figure(figsize=(8,4))
plt.plot(err[err>0])
plt.show()
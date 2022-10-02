
import multiprocessing as mp



def launch1(q):
    import train_dreambooth_unet
    train_dreambooth_unet.main(q)
    q.get()

def launch2(q):
    import train_dreambooth_vae
    train_dreambooth_vae.main(q)
    q.put(None)

q = mp.Queue(1)

p1 = mp.Process(target=launch1, args=(q,))
p2 = mp.Process(target=launch2, args=(q,))
p1.start()
p2.start()


p1.join()
q.close()
p2.terminate()
p2.join()

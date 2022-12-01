import random

denoms = list((range(10)))
random.shuffle(denoms)

# The 'f's are f string which make string interpolation easier
# for i in range(10):
#     print(f'i: {i}') 
#     x = denoms[i]
#     print(f'x: {x}')
#     result = 100 / x


# for i in range(10):
#     import pdb; pdb.set_trace() #Helpful function to debug functions
#     x = denoms[i]
#     result = 100 / x


for i in range(10):
    x = denoms[i]
    try:
        result = 100 / x
    except:
        import pdb; pdb.set_trace()
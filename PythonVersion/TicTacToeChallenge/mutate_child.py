import mutate as m
def mutate_child(child, mutation_rate):
    prob = mutation_rate
    mr = mutation_rate
    i = 0
    while (i < 5):
        return_child = m.mutate(child,prob, mr)
        prob /= 2
        mr *= 2
        i += 1
    return return_child

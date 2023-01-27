target_sum = 5
input = [1, 2, 3, 4, 6]


def two_sum_two_pointers(input, target_sum):
    first = 0
    last = len(input) -1

    while first < last:
        sum = input[first] + input[last]
        if sum == target_sum:
            print(input[first], input[last])
            return first, last
        elif sum > target_sum:
            last = last -1
        elif sum < target_sum:
            first = first +1

def two_sum_hashtable(input, target_sum):
    dict_a = dict()
    for i in range(len(input)):
        searched_pair = target_sum - input[i]
        if searched_pair not in dict_a:
            dict_a[input[i]] = i
        else:
            return i, dict_a[searched_pair]

# two_sum_two_pointers(input, target_sum)
vlad = two_sum_hashtable(input, target_sum)


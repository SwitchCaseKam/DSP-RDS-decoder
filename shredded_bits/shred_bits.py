from random import randint
import re

def shred_bits(input_file_name, chunk_size_start, chunk_size_end, remove_kth_element=100):
    input_file_content=""
    with open(input_file_name) as input_file:
        input_file_content = str(input_file.read())
        input_file_array = input_file_content.split('\n')
        print(len(input_file_array))
        chunk_size = randint(chunk_size_start, chunk_size_end)
        print(chunk_size)
        f = lambda input_file_array, n=chunk_size: [input_file_array[i:i+n] for i in range(0, len(input_file_array), n)]
        input_file_array_chunks = f(input_file_array)
        input_file_array_chunks.pop()
        print(len(input_file_array_chunks))
        print(remove_kth_element)
        del input_file_array_chunks[remove_kth_element - 1::remove_kth_element]
        print(len(input_file_array_chunks))

        output_file_name = input_file_name.replace('.txt', '_shredded.txt')
        with open(output_file_name, "w") as output_file:
            for input_file_array_chunk_element in input_file_array_chunks:
                for inside_chunk_element in input_file_array_chunk_element:
                    output_file.write(inside_chunk_element+"\n")


#shred_bits("PR2_log1.txt", 26, 104, 2)


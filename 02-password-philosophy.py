import re


def check_password(input_file):
    file_contents = []
    with open(input_file, 'r') as infile:
        file_contents = infile.read().splitlines()

    password_matches = []
    new_policy_valid = []
    for line in file_contents:
        numbers = line.split(" ",1)[0]
        num_range= numbers.split("-")
        num_min = int(num_range[0])
        num_max = int(num_range[-1])
        key_char = line.split(" ")[1].replace(":","")
        password = line.split(" ")[-1]        
        policy = re.compile(rf"{key_char}{{{num_min},{num_max}}}")
        key_char_count = password.count(key_char)
        if key_char_count>= num_min and key_char_count <= num_max:
            password_matches.append(password)

        if password[num_min-1] != key_char and password[num_max -1] == key_char:
            new_policy_valid.append(password)
        elif password[num_min-1] == key_char and password[num_max -1] != key_char:
            new_policy_valid.append(password)
        else:
            continue
    return password_matches, new_policy_valid
        
def main():
    pw_matches, new_policy_matches = check_password("input/02.txt")
    print(f"{len(pw_matches)} good passwords in original policy")
    print(f"{len(new_policy_matches)} good passwords in new policy")

    

if __name__ == "__main__":
    main()

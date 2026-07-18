def palindrome(word):

    if word.lower() == word.lower()[::-1]:
        print(f"{word} is a palindrome")
    else:
        print(f"{word} is not a palindrome")

palindrome("MadAm")
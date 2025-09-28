from collections import Counter

class Solution:
    def maxNumberOfBalloons(self, text: str) -> int:
        freq = Counter(text)
        need = {'b': 1, 'a': 1, 'l': 2, 'o': 2, 'n': 1}
        return min(freq[ch] // need[ch] for ch in need)
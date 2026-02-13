class Solution:
    def checkIfPangram(self, sentence: str) -> bool:
        for ch in 'abcdefghijklmnopqrstuvwxyz':
            if ch not in sentence.lower():
                return False
        return True
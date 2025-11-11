class Solution:
    def isValid(self, s: str) -> bool:
        check = []
        pairs = {')': '(', ']': '[', '}': '{'}

        for ch in s:
            if ch in pairs.values():
                check.append(ch)
            else:
                if not check or check[-1] != pairs[ch]:
                    return False
                check.pop()
            
        return not check
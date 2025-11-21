class Solution:
    def countPalindromicSubsequence(self, s: str) -> int:
        n = len(s)
        
        first = [n] * 26
        last = [-1] * 26
        
        for i, ch in enumerate(s):
            idx = ord(ch) - ord('a')
            first[idx] = min(first[idx], i)
            last[idx] = max(last[idx], i)
        
        result = 0
        
        for c in range(26):
            if first[c] < last[c]:
            
                seen = set()
                left = first[c] + 1
                right = last[c]
                for i in range(left, right):
                    seen.add(s[i])
                result += len(seen)
        
        return result
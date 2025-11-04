class Solution:
    def findXSum(self, nums: List[int], k: int, x: int) -> List[int]:
        n = len(nums)
        ans = []
        for i in range(n - k + 1):
            window = nums[i:i+k]
            cnt = Counter(window)  

            top = sorted(cnt.items(), key=lambda p: (-p[1], -p[0]))[:x]

            ans.append(sum(val * freq for val, freq in top))
        return ans
class Solution:
    def fizzBuzz(self, n: int) -> List[str]:
        result = []
        for i in range(1, 1+n):
            if i % 3 == 0 and i % 5 == 0:
                result.append("FizzBuzz")
            elif i % 5 == 0:
                result.append("Buzz")
            elif i % 3 == 0:
                result.append("Fizz")
            else:
                result.append(str(i))
        return result
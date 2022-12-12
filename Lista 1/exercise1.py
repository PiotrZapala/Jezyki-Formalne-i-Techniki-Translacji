import sys

class FiniteAutomaton:

    def __init__(self, text, pattern, alphabet, m):
        self.text = text
        self.pattern = pattern
        self.alphabet = alphabet
        self.m = m
        self.results = []
        self.finiteAutomatonMatcher(text, (self.computeTransitionFunction(pattern, alphabet)), m)

    def finiteAutomatonMatcher(self, text, delta, m):
        q = 0
        n = len(text)
        for i in range(n):
            q = delta[q, text[i]]
            if q == m: 
                self.results.append(i - m + 1)
        

    def computeTransitionFunction(self, pattern, alphabet):
        m = len(pattern)
        result = {(q, a): 0 for q in range(m + 1) for a in alphabet}
        for q in range(m+1):
            for a in alphabet:
                k = min([m, q+1])
                while k > 0 and pattern[:k] != (pattern[:q] + a)[-k:]:
                    k -= 1
                result[q, a] = k        
        return result
    
class KnuthMorrisPratt:

    def __init__(self, text, pattern):
        self.text = text
        self.pattern = pattern
        self.results = []
        self.knuthMorrisPrattMatcher(text, pattern)

    def knuthMorrisPrattMatcher(self, text, pattern):
        n = len(text)
        m = len(pattern)
        pi = self.computePrefixFunction(pattern)
        q = 0
        for i in range(n):
            while q > 0 and pattern[q] != text[i]:
                q = pi[q - 1] + 1
            if pattern[q] == text[i]:
                q = q + 1
                if q == m:
                    self.results.append(i - m + 1)
                    q = pi[q - 1] + 1

    def computePrefixFunction(self, pattern):
        m = len(pattern)
        pi = [None]*m
        pi[0] = -1
        k = -1
        for q in range(1, m):
            while k > -1 and pattern[k + 1] != pattern[q]:
                k = pi[k]
            if pattern[k + 1] == pattern[q]:
                k = k + 1
            pi[q] = k
        return pi


def initialization(algorithm, p, t):
    f = open(t, 'r', encoding='utf-8')
    text = list(f.readline().strip())
    pattern = str(p)
    alphabet = {a for a in text}
    m = len(pattern)
    if algorithm == 'FA':
        FA = FiniteAutomaton(text, pattern, alphabet, m)
        print(FA.results)
    elif algorithm == 'KMP':
        KMP = KnuthMorrisPratt(text, pattern)
        print(KMP.results)
    else:
        print('Wrong type of the algorithm!')
        sys.exit(0)


if __name__ == '__main__':
    initialization(str(sys.argv[1]), str(sys.argv[2]), str(sys.argv[3]))

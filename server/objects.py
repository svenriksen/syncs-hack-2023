class User:
    def __init__(self, accID : str):
        self.accID : str = accID

    def getID(self):
        return self.accID

class Book:
    def __init__(self, name : str, rating : int = None, n_read : int = 1, url : str = None):
        self.name = name
        self.rating = rating
        self.n_read = n_read
        self.url = url
    def __str__(self):
        return f'''
Book: {self.name}
\tRatings: {self.rating}
\tRead times: {self.n_read}
\tURL: {self.url}
'''
    @staticmethod
    def combineBooks(books):
        ans = []
        for book in books:
            ans.append(book)
        return ans

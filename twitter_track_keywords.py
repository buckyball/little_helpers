'''
    A script for analyzing twitter stats on things and stuff
'''
import tweepy

ENABLE_OUTPUT = True

buzzwords = {"bmw": {"count":0, "tweets": []}, "recklinghausen": {"count":0, "tweets": []}, "pommes":{"count":0, "tweets": []}, "pryzbilla":{"count":0, "tweets": []},"grasekamp":{"count":0, "tweets": []}}

def get_api():
    with open('config') as f:
        api_key = f.readline().strip()
        api_secret = f.readline().strip()
        access_token = f.readline().strip()
        access_token_secret = f.readline().strip()
        auth = tweepy.OAuthHandler(api_key, api_secret)
        auth.set_access_token(access_token, access_token_secret)
        return auth

def print_stats(cycle):
    for word in buzzwords.keys():
        print "-"*80
        print "Cycle %d" % (cycle)
        print "Word: %s , count: %s" % (word, buzzwords[word]["count"])
        for tweet in buzzwords[word]["tweets"]:
            print "\t%s\nn" % tweet
    print "\n---\n\n"

class CustomStreamListener(tweepy.StreamListener):
    cycles = 0

    def get_cycles(self):
        return self.cycles

    def f7(seq):
        seen = set()
        seen_add = seen.add
        return [ x for x in seq if not (x in seen or seen_add(x))]

    def on_status(self, status):
        self.cycles += 1
        lowered = status.text.lower()

        #
        # TODO:
        # would be nice, but I dunno how to get the matched key to update stats
        # if any(word in buzzwords.keys() for word in list_):
        #

        for key in buzzwords.keys():
            if key in lowered:
                buzzwords[key]["count"] += 1
                buzzwords[key]["tweets"].append(status.text)
                buzzwords[key]["tweets"] = list(set(buzzwords[key]["tweets"]))

        # display found occurrences if enabled
        if ENABLE_OUTPUT:
            print_stats(self.cycles)


if __name__ == '__main__':
    auth = get_api()
    l = CustomStreamListener()
    streaming_api = tweepy.Stream(auth, l)
    streaming_api.filter(track=buzzwords.keys())

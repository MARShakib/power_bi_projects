import pandas as pd
import pyodbc
import nltk
from nltk.sentiment.vader import SentimentIntensityAnalyzer

nltk.download('vader_lexicon')

customer_reviews_df = pd.read_csv('fact_customer_reviews.csv')

sia = SentimentIntensityAnalyzer()

def get_sentiment_score(review):
    sentiment = sia.polarity_scores(review)
    return sentiment['compound']

def get_sentiment_category(score, rating):
    if score > 0.05:
        if rating >= 4:
            return 'Positive'
        elif rating == 3:
            return 'Mixed Positive'
        else:
            return 'Mixed Negative'
    elif score < -0.05:
        if rating <= 2:
            return 'Negative'
        elif rating == 3:
            return 'Mixed Negative'
        else:
            return 'Mixed Positive' 
    else:
        if rating >= 4:
            return 'Positive' 
        elif rating <= 2:
            return 'Negative'
        else:
            return 'Neutral'

def get_sentiment_bucket(score):
    if score >= 0.5:
        return '0.5 to 1.0'
    elif score >= 0 and score < 0.5:
        return '0.0 to 0.49'
    elif score > -0.5 and score < 0.0:
        return '-0.49 to 0.0'
    else:
        return '-1.0 to -0.5'

customer_reviews_df['SentimentScore'] = customer_reviews_df['ReviewText'].apply(get_sentiment_score)

customer_reviews_df['SentimentCategory'] = customer_reviews_df.apply(
    lambda row: get_sentiment_category(row['SentimentScore'], row['Rating']), axis = 1
)

customer_reviews_df['SentimentBucket'] = customer_reviews_df['SentimentScore'].apply(get_sentiment_bucket)

print(customer_reviews_df.head())

customer_reviews_df.to_csv('fact_customer_reviews_with_sentiment.csv',index=False)

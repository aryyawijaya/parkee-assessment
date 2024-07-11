import requests
import pandas as pd

def show_universities_data(country):
    print("Fetching universites data with country={country}...".format(country=country))
    url = f'http://universities.hipolabs.com/search?country={country.replace(" ", "%20")}'
    response = requests.get(url)
    resp = response.json()
    
    # Convert JSON to DataFrame
    df = pd.DataFrame(resp)
    
    # Rename columns
    df = df.rename(columns={
        'name': 'Name',
        'web_pages': 'Web pages',
        'country': 'Country',
        'domains': 'Domains',
        'state-province': 'State Province'
    })
    print(df)
    print()
    
    # Filter out rows where 'State Province' is None
    df = df[df['State Province'].notna()]
    print("Filtering rows that State Province is None...")
    print(df)

    # Save to file
    df.to_csv('result_df.csv', index=False)

# Usage
country = 'United States'
show_universities_data(country)

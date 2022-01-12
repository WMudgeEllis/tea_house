# README

## Schema


![Screen Shot 2022-01-10 at 10 44 18 AM](https://user-images.githubusercontent.com/84806907/148813393-2de5e9f3-e14e-4a66-abf0-d3cffcfc4ec7.png)


## Endpoints


### create a subscription

post /api/v1/subscriptions

Required parameters:

* customer_id: integer, must be a valid id
* title: string
* price: integer, in cents as a whole number. E.g. $3.35 is 335
* frequency: integer, in days
* tea_ids: array of valid tea ids

Response
```
{
    "data": {
        "id": 15,
        "type": "subscription",
        "attributes": {
            "customer_id": 1,
            "title": "'best subscription ever'",
            "price": 1800,
            "frequency": 7,
            "status": "active"
        },
        "teas": [
            {
                "id": 1,
                "type": "tea",
                "attributes": {
                    "title": "Green Tea",
                    "description": "Mild, moderate caffine",
                    "temperature": 80,
                    "brew_time": 180
                }
            },
            {
                "id": 2,
                "type": "tea",
                "attributes": {
                    "title": "Gray tea",
                    "description": "Is a mild earl grey tea, milk is welcome",
                    "temperature": 93.0,
                    "brew_time": 240
                }
            }
        ]
    }
}

```
### notes
* temperature is in celcius
* brew_time is in seconds

### cancel a subscription
post /api/v1/subscriptions/:id

Required parameters:
* status: string, must be 'cancelled' otherwise the subscription will not be cancelled


example response
```
{
    "data": {
        "id": 1,
        "type": "subscription",
        "attributes": {
            "customer_id": 1,
            "title": "'best subscription ever'",
            "price": 1800,
            "frequency": 7,
            "status": "cancelled"
        }
    }
}
```

### notes
Can easily be tweaked to a general update endpoint.


### get a customer's subscriptions

get /api/v1/customers/:customer_id/subscriptions

No required parameters


example response
```
    "data": {
        "active_subscriptions": [
            {
                "id": 2,
                "type": "subscription",
                "attributes": {
                    "customer_id": 1,
                    "title": "'best subscription ever'",
                    "price": 1800,
                    "frequency": 7,
                    "status": "active"
                }
            }
          ],
        "cancelled_subscriptions": [
            {
                "id": 1,
                "type": "subscription",
                "attributes": {
                    "customer_id": 1,
                    "title": "'best subscription ever'",
                    "price": 1800,
                    "frequency": 7,
                    "status": "cancelled"
                }
            }
        ]
```

# lambda_aws_actions

Lambda function for quick actions on AWS instances

## Avaliable functions

- get RDS instance url
- get EC2 instance status

## Use

Send a post request to the API gateway with required headers. Postman makes this easy:

![postmanscreenshot](/images/postman.png)

### Headers

#### required

| Header | Action | Notes |
|--------|--------|-------|
|x-api-key| Key for api gateway| 
|password|password to use the api|Unsalted and not a good example of security

#### optional

| Header | Action | Notes |
|--------|--------|-------|
|server_id| EC2 instance ID to run cmds against|
|action | Task to run | Will return a list of avaliable actions if left blank
| database | Human readable database name of an RDS instance | 

## TODO

- [ ] Power on Ec2 function
- [ ] Restart database function
- [ ] Handle wrong flags set
- [ ] GUI?
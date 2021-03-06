# lambda_aws_actions
![build status](https://jenkins.zibbytechnology.ddns.net/job/zibby/job/lambda_aws_actions/job/master/badge/icon)

Lambda function for quick actions on AWS instances

## Avaliable functions

- get RDS instance url
- get EC2 instance status
- restart RDS instance
- power on EC2 instance

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

#### actions

| Action | Requirements | Notes |
|--------|--------------|----------|
| teapot  | none | Returns a 418 statuscode, used for testing  |
| server_status | server_id | |
| start_server| server_id | Returns previous and current state|
| database_address | database | |
| restart_database| database| |


### Flow Diagram

![flowdiagram](/images/flow_dir.jpg)

---

## TODO

- [x] Power on Ec2 function
- [x] Restart database function
- [ ] Handle wrong flags set
- [ ] GUI?

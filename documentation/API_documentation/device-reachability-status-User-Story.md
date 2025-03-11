
# Device Reachability API User Story

| **Item** | **Details** |
| ---- | ------- |
| ***Summary*** | As a developer of a telephone number validation service, I want to check if a given phone number is assigned to any Device, and if the Device is currently reachable by the Operator so that I can inform my customer to accept or deny a phone number into their system. |
| ***Actors and Scope*** | **Actors:** Application service provider (ASP), Communication Service Provider (CSP). <br>**Scope:** ASP:User asks ASP to check if a phone number is valid. The phone number is specified by the ASP:User. 
| ***Pre-conditions*** |The preconditions are listed below:<br><ol><li>The ASP:BusinessManager and ASP:Administrator have been onboarded to the CSP's API platform.</li><li>The ASP:BusinessManager has successfully subscribed to the Reachability API product from the CSP's product catalog.</li><li>The ASP:Administrator has onboarded the ASP:User to the platform.</li><li>The ASP:User performs an authorization request to ASP</li><li>The ASP performs an authorisation request to CSP</li><li> The CSP checks access for the ASP then provide access token to the ASP</li><li>The ASP:User get the access token, allowing a secure access of the API.|
| ***Activities/Steps*** | **Starts when:** The ASP makes a POST request via the Reachability API, providing the phone number.<br>**Ends when:** The CSP's Reachability Server responds indicating whether the phone number is assigned to a Device and also if the Device is currently reachable |
| ***Post-conditions*** | The ASP could continue offering its service to the ASP:User with the confirmation of the validity of the phone number based on the Reachability information. |
| ***Exceptions*** | Several exceptions might occur during the Reachability API operations<br>- Unauthorized: Not valid credentials (e.g., use of already expired access token).<br>- Invalid input: Not valid input data to invoke operation (e.g., improperly formatted phone number).<br>- Not able to provide: Legal restrictions or data retention policies preventing the retrieval of the requested information.|

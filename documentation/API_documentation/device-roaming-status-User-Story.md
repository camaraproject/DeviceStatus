# Device Roaming Status User Story

| Item                      | Description | Support Qualifier |
|---------------------------|-------------|-------------------|
| Summary                   |      As an enterprise application developer, I want to query the roaming status of a user's device, so that I can determine if a device is in a foreign network and in which country it is located. This API can be used to identify fraud, ensure regulatory compliance, or enforce territorial restrictions on video and audio content.       | M                 |
| Roles, Actor(s) and scope |    **Roles:** Customer:Developer<br>**Actors:** Application service providers (ASP), hyperscalers, application developers.<br>**Scope:** Order To Activate (OTA) - Get roaming status of a device         | M                 |
| NF Requirements           |       -      | O                 |
| Pre-conditions            |      - The customer:developer has been successfully onboarded to the API platform of the service provider  <br>- The customer application has requested and received an access token with the required scope for the API        | M                 |
| Begins when               |      The customer application server makes a POST request to retrieve the roaming status of a user's device       | M                 |
| Ends when                 |      The service provider returns the roaming status of the device with a timestamp when the status information was updated. In case of a roaming situation also the roaming country name and code shall be returned.        |                  |
| Post-conditions           |       -      | M                 |
| Exceptions                |      Several exceptions might occur during the API operations:<br>- Unauthorized: Invalid credentials (e.g., expired access token).<br>- Incorrect input data (e.g., malformed phone number). <br>- Not found: The phone number is not associated with a CSP customer account      | M                 | 

# Linking a user story to API design

Once we have the user story, the next step is to clarify the **data journey** in the context of the target and source systems we are integrating:
- Think about triggers for workflows: how and when does data need to be moved between the application and the service?
- Think about dependencies of data objects: does the data in underlying objects need to be regularly kept in sync with another system?
- Think about any parameters the user might need to configure or change. This is particularly important when building self-serve integrations for non-technical end users.
- Think about privacy by design: does any data represent sensitive information, and how can this be safely shared/stored according to regulation (e.g., anonymisation, tokenisation, zero-trust principles)


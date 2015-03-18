#global variables for configuration

$ZENBASE = "http://zenoss.yourdomain.com";
$ZAPIUSER= "username";
$ZAPIPASS = "password";

Function zWinPost
{
    param($ROUTER_ENDPOINT, $ROUTER_ACTION, $ROUTER_METHOD, $DATA);

    $DATA='['+$DATA+']'

    $json = '{"action": "' + $ROUTER_ACTION + '","method": "' + $ROUTER_METHOD + '","data":' + $DATA + ', "tid":1}'
    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $ZAPIUSER,$ZAPIPASS)))
   
    $output = Invoke-RestMethod -Uri "$ZENBASE/zport/dmd/$ROUTER_ENDPOINT" -Method Post -ContentType "application/json" -Headers @{Authorization=("Basic {0}" -f $base64AuthInfo)} -Body $json

    return $output

    } 

Function zWinGetDevices
{
    $ROUTER_ENDPOINT = "device_router"
    $ROUTER_ACTION = "DeviceRouter"
    $ROUTER_METHOD = "getDevices"
    $DATA = '{}'

    $devJSON = zWinPost $ROUTER_ENDPOINT $ROUTER_ACTION $ROUTER_METHOD $DATA

    $devJSON.result.devices 
}
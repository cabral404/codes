<?php
    $url        = "https://www.cloudflare.com/api_json.html";
    $ip         = $_SERVER['REMOTE_ADDR'];
    $domain     = $_GET['domain'];
    $action     = $_GET['action'];
    $rec_id     = $_GET['rec_id'];
    $type       = $_GET['type'];
    $mode       = $_GET['mode'];
    $ttl        = $_GET['ttl'];
    $sub_domain = $_GET['sub'];
    $user       = $_GET['user'];
    $key        = $_GET['key'];

    $postfields = array("a"             => $action,
                        "tkn"           => $key,
                        "id"            => $rec_id,
                        "email"         => $user,
                        "z"             => $domain,
                        "type"          => $type,
                        "name"          => $sub_domain,
                        "content"       => $ip,
                        "service_mode"  => $mode,
                        "ttl"           => $ttl);

    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $postfields);

    curl_exec($ch);
    curl_close($ch);
    unset($ch);
?>

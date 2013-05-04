<?php
// simple test for the question and answer system

$qs = array(
	"whats you fav color?",
	'how old are you?'
);
$a = array();

foreach($qs as $key => $q){
	echo ($key+1).') '.$q.PHP_EOL;
	$a[$q] = substr(fgets(STDIN),0,-1);
}
echo PHP_EOL.'ANSWERS:'.PHP_EOL;

echo json_encode($a);
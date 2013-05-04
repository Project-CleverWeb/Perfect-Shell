<?php 
/**
 * @copyright Nicholas Jordon
 */
class sh_color {
	private $txt_colors = array();
	private $txt_styles = array();
	private $bg_colors  = array();

	public function __construct(){
		// Set up colors
		$this->txt_colors = array(
			// regular
			'gray'         => '30',
			'red'          => '31',
			'green'        => '32',
			'yellow'       => '33',
			'blue'         => '34',
			'purple'       => '35',
			'cyan'         => '36',
			'white'        => '37',
			// light
			'light_gray'   => '90',
			'light_red'    => '91',
			'light_green'  => '92',
			'light_yellow' => '93',
			'light_blue'   => '94',
			'light_purple' => '95',
			'light_cyan'   => '96',
			'light_white'  => '97'
		);
		$this->txt_styles = array(
			'regular'      => '0',
			'bold'         => '1',
			'dark'         => '2', // this + gray = black
			'underline'    => '4',
			'invert'       => '7',
			'strike'       => '9'
		);
		$this->bg_colors = array(
			// regular
			'gray'         => '40',
			'red'          => '41',
			'green'        => '42',
			'yellow'       => '43',
			'blue'         => '44',
			'purple'       => '45',
			'cyan'         => '46',
			'white'        => '47',
			// light
			'light_gray'   => '100',
			'light_red'    => '101',
			'light_green'  => '102',
			'light_yellow' => '103',
			'light_blue'   => '104',
			'light_purple' => '105',
			'light_cyan'   => '106',
			'light_white'  => '107'
		);
	}

	// Returns colored string
	public function color_string($string, $txt_color=NULL, $bg_color=NULL, $txt_style=NULL){
		$return = "\033[0m"; // start with blank slate
		$style = '0';
		if(stripos($txt_style, ',')){
			$styles = explode(',', (string) $txt_style);
			$style = '';
			foreach ($styles as $value) {
				if(isset($this->txt_styles[strtolower((string) $value)])){
					$style .= $this->txt_styles[strtolower((string) $value)].';';
				}
			}
		}
		else{
			if(isset($this->txt_styles[strtolower((string) $txt_style)])){
				$style = $this->txt_styles[strtolower((string) $txt_style)].';';
			}
		}
		// if neither txt or bg are set, remove the last ';'
		if(!(
			isset($this->txt_colors[strtolower((string) $txt_color)]) ||
			isset($this->bg_colors[strtolower((string) $bg_color)])
		)){
			$style = substr($style,0,-1);
		}
		if(isset($this->txt_colors[strtolower((string) $txt_color)])){
			$return .= "\033[".$style.$this->txt_colors[strtolower((string) $txt_color)] . "m";
		}
		else{
			$return .= "\033[".$style."m";
		}
		if(isset($this->bg_colors[strtolower((string) $bg_color)])){
			$return .= "\033[".$this->bg_colors[strtolower((string) $bg_color)] . "m";
		}
		$return .=  $string . "\033[0m";
		
		return $return;
	}
	
	public function get_txtstyles() {
		return array_keys($this->txt_styles);
	}
	
	public function get_txtcolors() {
		return array_keys($this->txt_colors);
	}
	
	public function get_bgcolors() {
		return array_keys($this->bg_colors);
	}
}

$color = new sh_color;

// get arguments
$longopts = array(
	'no-stdin',
	'print-all'
);
$args = getopt('s:S:c:C:f:',$longopts);

// stdin
$stdin = '';
if(!isset($args['no-stdin'])){
	if(!posix_isatty(STDIN)){$stdin = substr(file_get_contents('php://stdin'),0,-1);}
}

// test if arguments exist
if(empty($args['c'])){
	$args['c'] = NULL; // prevents error
}
if(empty($args['C'])){
	$args['C'] = NULL; // prevents error
}
if(empty($args['S'])){
	$args['S'] = NULL; // prevents error
}

if(empty($args['s'])){
	if(empty($stdin) && is_file($args['f'])==FALSE){
		// error out if no string
		$args['s'] = 'ERROR: No content available, please use STDIN, -f or -s';
		$args['S'] = 'dark';
		$args['c'] = 'gray';
		$args['C'] = 'light_red';
	}
	elseif(!empty($args['f'])){
		$args['s'] = file_get_contents($args['f']);
	}
	else{
		$args['s'] = (string) $stdin;
		$str_switch = TRUE;
	}
}

if(isset($args['print-all'])){
	// print all the possiblities
	$output = '';
	foreach ($color->get_txtstyles() as $value) {
		$output .= $color->color_string('This is the txt style: '.$value, 'green', NULL, $value).PHP_EOL;
	}
	foreach ($color->get_txtcolors() as $value) {
		$output .= $color->color_string('This is the txt color: '.$value, $value).PHP_EOL;
	}
	foreach ($color->get_bgcolors() as $value) {
		$output .= $color->color_string('This is the bg color: '.$value, 'gray', $value, 'dark').PHP_EOL;
	}
}
else{
	// or print the inputs
	$output = $color->color_string($args['s'], $args['c'], $args['C'], $args['S']);
}

if(isset($str_switch) || isset($args['print-all'])){echo $output;}
else{echo $stdin.$output;}


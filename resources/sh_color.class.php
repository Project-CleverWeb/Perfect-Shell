<?php 
// standard class (non cmd-line friendly)
// cmd-line friendly moved to /resources/commands
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
		// ensure only a string is given
		$txt_style = strtolower((string) $txt_style);
		$txt_color = strtolower((string) $txt_color);
		$bg_color = strtolower((string) $bg_color);
		$string = strtolower((string) $string);
		if(stripos($txt_style, ',')){
			$styles = explode(',', $txt_style);
			$style = '';
			foreach ($styles as $value) {
				if(isset($this->txt_styles[$value])){
					$style .= $this->txt_styles[$value].';';
				}
			}
		}
		else{
			if(isset($this->txt_styles[$txt_style])){
				$style = $this->txt_styles[$txt_style].';';
			}
		}
		// if neither txt or bg are set, remove the last ';'
		if(!(
			isset($this->txt_colors[$txt_color]) ||
			isset($this->bg_colors[$bg_color])
		)){
			$style = substr($style,0,-1);
		}
		if(isset($this->txt_colors[$txt_color])){
			$return .= "\033[".$style.$this->txt_colors[$txt_color] . "m";
		}
		else{
			$return .= "\033[".$style."m";
		}
		if(isset($this->bg_colors[$bg_color])){
			$return .= "\033[".$this->bg_colors[$bg_color] . "m";
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
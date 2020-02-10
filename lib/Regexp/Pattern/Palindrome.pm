package Regexp::Pattern::Palindrome;

# AUTHORITY
# DATE
# DIST
# VERSION

our %RE = (
    palindrome_alphanum => {
        summary => 'Palindrome alphanumeric word (single alphanum included)',
        pat => qr/((\w)(?1)\2|\w?)/,
        tags => ['capturing'],
        examples => [
            {str=>'foo', anchor=>1, matches=>0},
            {str=>'Aa', anchor=>1, matches=>0},
            {str=>'-', anchor=>1, matches=>0},
            {str=>'a-a', anchor=>1, matches=>0},

            {str=>'a', anchor=>1, matches=>1},
            {str=>'aa', anchor=>1, matches=>1},
            {str=>'zzz', anchor=>1, matches=>1},
            {str=>'kodok', anchor=>1, matches=>1},
            {str=>'20200202', anchor=>1, matches=>1, summary=>'Feb 2nd, 2020 in YYYYMMDD format'},
        ],
    },
    gen_palindrome_alphanum => {
        summary => 'Generate regex to match palindrome alphanumeric word of certain minimum length',
        gen_args => {
            min_len => {
                schema => ['int*', is=>[1,3,5,7,9,11,13,15]],
                req => 1,

            },
        },
        gen => sub {
            my %args = @_;
            my $min_len = $args{min_len};
            if    ($min_len ==  1) { return qr/                             ((\w)(?1)\2|\w?)               /x }
            elsif ($min_len ==  3) { return qr/                         (\w)((\w)(?2)\3|\w?)\1             /x }
            elsif ($min_len ==  5) { return qr/                     (\w)(\w)((\w)(?3)\4|\w?)\2\1           /x }
            elsif ($min_len ==  7) { return qr/                 (\w)(\w)(\w)((\w)(?4)\5|\w?)\3\2\1         /x }
            elsif ($min_len ==  9) { return qr/             (\w)(\w)(\w)(\w)((\w)(?5)\6|\w?)\4\3\2\1       /x }
            elsif ($min_len == 11) { return qr/         (\w)(\w)(\w)(\w)(\w)((\w)(?6)\7|\w?)\5\4\3\2\1     /x }
            elsif ($min_len == 13) { return qr/     (\w)(\w)(\w)(\w)(\w)(\w)((\w)(?7)\8|\w?)\6\5\4\3\2\1   /x }
            elsif ($min_len == 15) { return qr/ (\w)(\w)(\w)(\w)(\w)(\w)(\w)((\w)(?8)\9|\w?)\7\6\5\4\3\2\1 /x }
            else  { die "Invalid value for min_len" }
        },
        tags => ['capturing'],
        examples => [
            {str=>'a'    , anchor=>1, gen_args=>{min_len=>1}, matches=>1},

            {str=>'a'    , anchor=>1, gen_args=>{min_len=>3}, matches=>0},
            {str=>'aaa'  , anchor=>1, gen_args=>{min_len=>3}, matches=>1},
            {str=>'aba'  , anchor=>1, gen_args=>{min_len=>3}, matches=>1},
            {str=>'abba' , anchor=>1, gen_args=>{min_len=>3}, matches=>1},
            {str=>'abcba', anchor=>1, gen_args=>{min_len=>3}, matches=>1},
            {str=>'abc'  , anchor=>1, gen_args=>{min_len=>3}, matches=>0},

            {str=>'a'     , anchor=>1, gen_args=>{min_len=>5}, matches=>0},
            {str=>'abcba' , anchor=>1, gen_args=>{min_len=>5}, matches=>1},
            {str=>'abccba', anchor=>1, gen_args=>{min_len=>5}, matches=>1},
            {str=>'abcde' , anchor=>1, gen_args=>{min_len=>5}, matches=>0},

            {str=>'a'       , anchor=>1, gen_args=>{min_len=>7}, matches=>0},
            {str=>'abcdcba' , anchor=>1, gen_args=>{min_len=>7}, matches=>1},
            {str=>'abcddcba', anchor=>1, gen_args=>{min_len=>7}, matches=>1},
            {str=>'abcdefg' , anchor=>1, gen_args=>{min_len=>7}, matches=>0},

            {str=>'a'         , anchor=>1, gen_args=>{min_len=>9}, matches=>0},
            {str=>'abcdedcba' , anchor=>1, gen_args=>{min_len=>9}, matches=>1},
            {str=>'abcdeedcba', anchor=>1, gen_args=>{min_len=>9}, matches=>1},
            {str=>'abcdefghi' , anchor=>1, gen_args=>{min_len=>9}, matches=>0},

            {str=>'a'           , anchor=>1, gen_args=>{min_len=>11}, matches=>0},
            {str=>'abcdefedcba' , anchor=>1, gen_args=>{min_len=>11}, matches=>1},
            {str=>'abcdeffedcba', anchor=>1, gen_args=>{min_len=>11}, matches=>1},
            {str=>'abcdefghijk' , anchor=>1, gen_args=>{min_len=>11}, matches=>0},

            {str=>'a'             , anchor=>1, gen_args=>{min_len=>13}, matches=>0},
            {str=>'abcdefgfedcba' , anchor=>1, gen_args=>{min_len=>13}, matches=>1},
            {str=>'abcdefggfedcba', anchor=>1, gen_args=>{min_len=>13}, matches=>1},
            {str=>'abcdefghijklm' , anchor=>1, gen_args=>{min_len=>13}, matches=>0},

            {str=>'a'               , anchor=>1, gen_args=>{min_len=>15}, matches=>0},
            {str=>'abcdefghgfedcba' , anchor=>1, gen_args=>{min_len=>15}, matches=>1},
            {str=>'abcdefghhgfedcba', anchor=>1, gen_args=>{min_len=>15}, matches=>1},
            {str=>'abcdefghijklmno' , anchor=>1, gen_args=>{min_len=>15}, matches=>0},
        ],
    },
);

1;
# ABSTRACT: Regexp patterns related to palindrome

=head1 SEE ALSO

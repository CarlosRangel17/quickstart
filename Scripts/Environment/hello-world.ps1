# Output example
echo "Hello world!"

# Looping example 
#$Packages = 'googlechrome', 'git', 'notepadplusplus', 'sql-server-management-studio'
ForEach ($PackageName in $Packages)
{
    echo $PackageName
}

# Looping through generic args
for ( $i = 0; $i -lt $args.count; $i++ ) {
    write-host "Argument  $i is $($args[$i])"
} 


 describe command('wget -o -http://localhost' ) do
 its('stdout') {should match(/Jenkins/)} 
 end 

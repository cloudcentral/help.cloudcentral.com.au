
cat _data/glossary.yml|awk -F\: '{print $1}'|sed 's/\"//g' | while read tag; do
echo "$tag"
echo ": {{site.data.glossary['$tag']}}"
echo
done
#31 <dt id="intrepid">intrepid</dt>
#!  32 <dd>{{site.data.glossary.tenant id}}</dd>

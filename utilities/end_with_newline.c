#include <stdlib.h>
#include <stdio.h>
#include <string.h>
 
int main (int argc, char* argv[])
{
  int i;
  char ch;
  long length;

  if (argc < 2)
  {
    printf ("usage: %s filename\n", argv[0]);
    exit (0);
  }

  for (i = 1; i < argc; i++)
  {
    FILE *ifp = fopen (argv[i], "r");

    if (ifp == NULL)
    {
      fprintf (stderr, "Could not open file '%s'.\n", argv[1]);
      continue;
    }

    fseek (ifp, 0, SEEK_END);
    length = ftell (ifp);
    fseek (ifp, (length-1), SEEK_SET);

    ch = fgetc (ifp);

    if (ch == '\n')
    {
      puts ("Newline already at end.");
      fclose (ifp);
      continue;
    }

    const char* ext = ".nl";
    size_t lenbase = strlen(argv[i]);
    size_t lenext = strlen(ext);
    char *ofname = malloc(lenbase + lenext + 1);
    strcpy(ofname, argv[i]);
    strcat(ofname, ext);
    FILE *ofp = fopen (ofname, "w");

    fseek (ifp, 0, SEEK_SET);
    while ((ch = fgetc(ifp)) != EOF)
      fputc (ch, ofp);
    fputc ('\n', ofp);

    puts ("Successfully appended file with newline.");
    printf ("Output: %s\n", ofname);

    free (ofname);

    fclose (ifp);
    fclose (ofp);
  }

  return(0);
}

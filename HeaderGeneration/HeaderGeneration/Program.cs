using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;

namespace HeaderGeneration
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //read file "src/dll/builtins.cpp"
            string[] lines = File.ReadAllLines("../src/dll/builtins.cpp");
            //delete the lines that dont have AddCustomFunction in them
            lines = lines.Where(x => x.Contains("AddCustomFunction")).ToArray();
            //print lines to console

            //trim lines to start at "
            for (int i = 0; i < lines.Length; i++)
            {
                //if line has GSCBuiltins::AddCustomFunction jumpy over it
                if (lines[i].Contains("GSCBuiltins::AddCustomFunction"))
                {

                    continue;

                }
                lines[i] = lines[i].Substring(lines[i].IndexOf('"'));
            }
            //trim everything behind the last "
            for (int i = 0; i < lines.Length; i++)
            {
                if (lines[i].Contains("GSCBuiltins::AddCustomFunction"))
                {

                    continue;

                }
                lines[i] = lines[i].Substring(0, lines[i].LastIndexOf('"'));
            }
            //remove the first character of each line
            for (int i = 0; i < lines.Length; i++)
            {
                if (lines[i].Contains("GSCBuiltins::AddCustomFunction"))
                {

                    continue;

                }
                lines[i] = lines[i].Substring(1);
                //convert to byte array
                byte[] bytes = Encoding.ASCII.GetBytes(lines[i]);
                //call HashFNV1a on byte array
                int hash = (int)HashFNV1a(bytes);
                //convert hash to hex
                //print hash to console
                Console.WriteLine(lines[i] + ": " + "0x" + hash.ToString("X"));
            }
        }

        public static int HashFNV1a(byte[] bytes)
        {
            int hash = 0x4B9ACE2F;

            for (var i = 0; i < bytes.Length; i++)
            {
                hash ^= bytes[i];
                hash *= 0x1000193;
                i++;
            }

            hash *= 0x1000193;
            return hash;
        }
    }
}

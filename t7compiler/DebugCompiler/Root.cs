﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using TreyarchCompiler;
using T7CompilerLib;
using TreyarchCompiler.Enums;
using T7CompilerLib.OpCodes;
using XDevkit;
using Microsoft.Test.Xbox.XDRPC;
using TreyarchCompiler.Utilities;
using System.Windows.Forms.VisualStyles;
using System.Globalization;
using System.Runtime.InteropServices;
using System.Diagnostics;
using System.Reflection;
using System.Net;
using T89CompilerLib;

namespace DebugCompiler
{
    class Root
    {
        static void Main(string[] args)
        {
            Root root = new Root();
            string file = "\\..\\GSC\\";
            string execPath = Directory.GetCurrentDirectory();
            string path = Path.Combine(execPath + file);
            Console.WriteLine(path);
            root.cmd_Compile(path);

        }

        private int Error(string msg = "Error encountered")
        {
            var old = Console.ForegroundColor;
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine(msg);
            Console.ForegroundColor = old;
            Console.WriteLine();
            Console.ReadKey();
            return 1;
        }

        private int Success(string msg = "")
        {
            var old = Console.ForegroundColor;
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine(msg);
            Console.ForegroundColor = old;
            Console.WriteLine();
            return 0;
        }

        #region commands

        private static Dictionary<uint, string> t8_dword;
        private static Dictionary<uint, string> t7_dword;
        private static Dictionary<ulong, string> t8_qword;
        private static void LoadHashTable(bool force = false)
        {
           
        }

        private int cmd_Inject(string file)
        {

            Games game = Games.T7;

            byte[] buffer = null;
            try
            {
                buffer = File.ReadAllBytes(file);
            }
            catch
            {
                return Error("Failed to read the file specified");
            }
            var path = @"scripts/shared/duplicaterender_mgr.gsc";
            PointerEx injresult = InjectScript(path, buffer, game, hotmode.none, false);


            if (!injresult)
            {
                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.WriteLine("Press any key to reset gsc parsetree... If in game, you are probably going to crash.\n");
                Console.ForegroundColor = ConsoleColor.Yellow;

                Console.ReadKey(true);
                NoExcept(FreeActiveScript);
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine("\tScript parsetree has been reset\n");
                Console.ForegroundColor = ConsoleColor.White;
            }
            return 0;
        }

        private int cmd_DumpEmptySlots(string[] args)
        {
            return -1;
        }

        private int cmd_migrateMap(string[] args)
        {
            return -1;
        }

        private int cmd_ExtractStrings(string[] args)
        {
            return -1;
        }

        public unsafe static string DecodeAscii(byte[] buffer, int index = 0)
        {
            fixed (byte* bytes = &buffer[index])
            {
                return new string((sbyte*)bytes);
            }
        }

        private int cmd_Collect(string[] args)
        {
            return -1;
        }

        private int cmd_Automap(string[] args)
        {
            return -1;
        }

        private int cmd_HashString(string[] args)
        {
            if (args.Length != 2 && args.Length != 4)
                return Error("Invalid arguments");

            string input;

            string method = args[0].Trim().ToLower();

            switch (method)
            {
                case "fnv64":
                    ulong fnv64Offset = 14695981039346656037;
                    ulong fnv64Prime = 0x100000001b3;

                    if (args.Length == 2)
                        input = args[1].Replace('"', ' ').Trim();
                    else
                    {
                        if (args.Length != 4)
                            return Error("Invalid arguments");
                        try
                        {
                            fnv64Offset = ulong.Parse(args[1].Trim().ToLower().Replace("0x", ""), System.Globalization.NumberStyles.HexNumber);
                            fnv64Prime = ulong.Parse(args[2].Trim().ToLower().Replace("0x", ""), System.Globalization.NumberStyles.HexNumber);
                            input = args[3].Replace('"', ' ').Trim();
                        }
                        catch
                        {
                            return Error("Invalid arguments");
                        }
                    }

                    Console.WriteLine(HashFNV1a(Encoding.ASCII.GetBytes(input), fnv64Offset, fnv64Prime).ToString("X8"));
                    return 0;

                case "fnv":
                    uint baseline = 0x4B9ACE2F;
                    uint prime = 0x1000193;

                    if (args.Length == 2)
                        input = args[1].Replace('"', ' ').Trim();
                    else
                    {
                        if (args.Length != 4)
                            return Error("Invalid arguments");
                        try
                        {
                            baseline = uint.Parse(args[1].Trim().ToLower().Replace("0x", ""), System.Globalization.NumberStyles.HexNumber);
                            prime = uint.Parse(args[2].Trim().ToLower().Replace("0x", ""), System.Globalization.NumberStyles.HexNumber);
                            input = args[3].Replace('"', ' ').Trim();
                        }
                        catch
                        {
                            return Error("Invalid arguments");
                        }
                    }

                    Console.WriteLine(Com_Hash(input, baseline, prime).ToString("X4"));
                    return 0;


                default:
                    return Error($"Invalid method '{method}'");
            }
        }


        private int cmd_GenerateHashMap(string[] args)
        {
            return -1;
        }

        private int cmd_Permute(string[] args)
        {
            return -1;
        }

        private int cmd_StatDump(string[] args)
        {
            return -1;
        }

        private string TryGetHash(string tok)
        {
            if (!long.TryParse(tok, NumberStyles.HexNumber, CultureInfo.InvariantCulture, out long resultant))
                return tok;
            if (t8_qword.TryGetValue((ulong)resultant, out string dehashed)) return dehashed;
            return tok;
        }

        private int cmd_Exit(string[] args)
        {
            Environment.Exit(0);
            return 0;
        }

        private int cmd_MapFileNS(string[] args)
        {
            return -1;
        }

        private int cmd_IncludeMapper(string[] args)
        {
            return -1;
        }

        private class SourceTokenDef
        {
            public string FilePath;
            public int LineStart;
            public int LineEnd;
            public int CharStart;
            public int CharEnd;
            public Dictionary<int, (int CStart, int CEnd)> LineMappings = new Dictionary<int, (int CStart, int CEnd)>();
        }

        private int cmd_Compile(string path)
        {


            if (!Directory.Exists(path))
                return Error("Path is either not a directory or does not exist");

            List<string> conditionalSymbols = new List<string>();
            string replaceScript = null;

            Platforms platform = Platforms.PC;
            Games game = Games.T7;
            hotmode hot = hotmode.none;
            bool noruntime = false;


                    game = Games.T7;


            if (File.Exists("gsc.conf"))
            {
                foreach (string line in File.ReadAllLines("gsc.conf"))
                {
                    if (line.Trim().StartsWith("#")) continue;
                    var split = line.Trim().Split('=');
                    if (split.Length < 2) continue;
                    switch (split[0].ToLower().Trim())
                    {
                        case "symbols":
                            foreach (string token in split[1].Trim().Split(','))
                            {
                                conditionalSymbols.Add(token);
                            }
                            break;
                        case "script":
                            replaceScript = split[1].ToLower().Trim().Replace("\\", "/");
                            break;
                        case "game":
                            if (!Enum.TryParse(split[1].ToLower().Trim().Replace("\\", "/"), true, out game))
                            {
                                game = Games.T7;
                            }
                            break;
                        case "hot":
                            if (!Enum.TryParse(split[1].ToLower().Trim(), true, out hot))
                            {
                                hot = hotmode.none;
                            }
                            break;
                        case "noruntime":
                            noruntime = split[1].ToLower().Trim() == "true";
                            break;
                    }
                }
            }

            bool isT7 = game == Games.T7;

            //if (args.Length > 1)
            //{
            //    if(!Enum.TryParse(args[1], true, out game))
            //    {
            //        game = Games.T7;
            //    }
            //}

            string source = "";
            CompiledCode code;
            List<SourceTokenDef> SourceTokens = new List<SourceTokenDef>();
            StringBuilder sb = new StringBuilder();
            int CurrentLineCount = 0;
            int CurrentCharCount = 0;
            foreach (string f in Directory.GetFiles(path, "*.gsc", SearchOption.AllDirectories))
            {
                var CurrentSource = new SourceTokenDef();
                CurrentSource.FilePath = f.Replace(path, "").Substring(1).Replace("\\", "/");
                CurrentSource.LineStart = CurrentLineCount;
                CurrentSource.CharStart = CurrentCharCount;
                foreach (var line in File.ReadAllLines(f))
                {
                    CurrentSource.LineMappings[CurrentLineCount] = (CurrentCharCount, CurrentCharCount + line.Length + 1);
                    sb.Append(line);
                    sb.Append("\n");
                    CurrentLineCount += 1;
                    CurrentCharCount += line.Length + 1; // + \n
                }
                CurrentSource.LineEnd = CurrentLineCount;
                CurrentSource.CharEnd = CurrentCharCount;
                // Console.WriteLine($"{CurrentSource.FilePath} start {CurrentSource.LineStart} end {CurrentSource.LineEnd}");
                SourceTokens.Add(CurrentSource);
                sb.Append("\n"); // remember that this is here because its going to fuck up irony
                end_loop:;
            }

            replaceScript = replaceScript ?? (isT7 ? @"scripts/shared/duplicaterender_mgr.gsc" : @"scripts/zm_common/load.gsc");
            source = sb.ToString();
            var ppc = new ConditionalBlocks();
            conditionalSymbols.Add(isT7 ? "BO3" : "BO4");
            ppc.LoadConditionalTokens(conditionalSymbols);
            
            try
            {
                source = ppc.ParseSource(source);
            }
            catch(CBSyntaxException e)
            {
                int errorCharPos = e.ErrorPosition;
                int numLineBreaks = 0;
                foreach(var stok in SourceTokens)
                {
                    do
                    {
                        if(errorCharPos < stok.CharStart || errorCharPos > stok.CharEnd)
                        {
                            break; // havent reached the target index set yet
                        }
                        // now we have the source file we want
                        errorCharPos -= numLineBreaks; // adjust for inserted linebreaks between files
                        foreach(var line in stok.LineMappings)
                        {
                            var constraints = line.Value;
                            if(errorCharPos < constraints.CStart || errorCharPos > constraints.CEnd)
                            {
                                continue; // havent found the index we want yet
                            }
                            // found the target line
                            return Error($"{e.Message} in scripts/{stok.FilePath} at line {line.Key - stok.LineStart}, position {errorCharPos - constraints.CStart}");
                        }
                    }
                    while (false);
                    numLineBreaks++;
                }
                return Error(e.Message);
            }

            code = Compiler.Compile(platform, game, Modes.MP, false, source);
            if (code.Error != null && code.Error.Length > 0)
            {
                if(code.Error.LastIndexOf("line=") < 0)
                {
                    return Error(code.Error);
                }
                int iStart = code.Error.LastIndexOf("line=") + "line=".Length;
                int iLength = code.Error.LastIndexOf("]") - iStart;
                int line = int.Parse(code.Error.Substring(iStart, iLength));
                // Console.WriteLine(code.Error + " :: " + line);
                foreach (var stok in SourceTokens)
                {
                    do
                    {
                        if(stok.LineStart <= line && stok.LineEnd >= line)
                        {
                            return Error($"Syntax error in scripts/{stok.FilePath} around line {line - stok.LineStart + 1}");
                        }
                    }
                    while (false);
                    line--; // acccount for linebreaks appended to each file
                }
                return Error(code.Error);
            }

            string cpath = $"compiled.{(code.RequiresGSI ? "gsic" : "gscc")}";
            File.WriteAllBytes(cpath, code.CompiledScript);
            string hpath = "hashes.txt";
            StringBuilder hashes = new StringBuilder();
            foreach(var kvp in code.HashMap)
            {
                hashes.AppendLine($"0x{kvp.Key:X}, {kvp.Value}");
            }
            File.WriteAllText(hpath, hashes.ToString());

            if(code.OpcodeEmissions != null)
            {
                byte[] opsRaw = new byte[code.OpcodeEmissions.Count * 4];
                for(int i = 0; i < code.OpcodeEmissions.Count; i++)
                {
                    BitConverter.GetBytes(code.OpcodeEmissions[i]).CopyTo(opsRaw, i * 4);
                }
                File.WriteAllBytes("compiled.omap", opsRaw);
            }
     
            Success(cpath);
            Success("Script compiled");


            byte[] data = code.CompiledScript;

            PointerEx injresult = InjectScript(replaceScript, code.CompiledScript, game, hot, noruntime);

            return 0;
        }

        private void FreeActiveScript()
        {
            switch(LastGameInjected)
            {
                case Games.T7:
                    NoExcept(FreeT7Script);
                    break;
                case Games.T8:
                    NoExcept(FreeT8Script);
                    break;
            }
        }

        private void NoExcept(Action a)
        {
            try
            {
                a();
            }
            catch { }
        }

        private Games LastGameInjected;
        private PointerEx llpModifiedSPTStruct = 0;
        private PointerEx llpOriginalBuffer;
        private int OriginalSourceChecksum;
        private int InjectedBuffSize;
        private T7SPT InjectedScript;
        private int OriginalPID = 0;
        private int InjectScript(string replacePath, byte[] buffer, Games game, hotmode hot, bool noruntime)
        {
            LastGameInjected = game;
            switch (game)
            {
                case Games.T7: return InjectT7(replacePath, buffer, hot, noruntime);
                case Games.T8: return InjectT8(replacePath, buffer);
            }
            return Error("Invalid game provided to inject.");
        }

        private class GSICInfo
        {
            public List<T7ScriptObject.ScriptDetour> Detours = new List<T7ScriptObject.ScriptDetour>();

            public byte[] PackDetours()
            {
                List<byte> data = new List<byte>();
                foreach(var detour in Detours)
                {
                    data.AddRange(detour.Serialize());
                }
                return data.ToArray();
            }
        }

        private class GSICInfoT8
        {
            public List<T89ScriptObject.ScriptDetour> Detours = new List<T89ScriptObject.ScriptDetour>();

            public byte[] PackDetours()
            {
                List<byte> data = new List<byte>();
                foreach (var detour in Detours)
                {
                    data.AddRange(detour.Serialize());
                }
                return data.ToArray();
            }
        }

        private enum hotmode
        {
            none,
            csc,
            gsc
        }

        private int InjectT7(string replacePath, byte[] buffer, hotmode hot, bool noruntime)
        {
            GSICInfo gsi = null;
            if (BitConverter.ToInt64(buffer, 0) != 0x1C000A0D43534780)
            {
                string preamble = Encoding.ASCII.GetString(buffer.Take(4).ToArray());
                if (preamble != "GSIC")
                {
                    return Error("Script is not a valid compiled script. Please use a script compiled for Black Ops III.");
                }
                using (MemoryStream ms = new MemoryStream(buffer))
                using (BinaryReader reader = new BinaryReader(ms))
                {
                    T7ScriptObject.GSIFields currentField = T7ScriptObject.GSIFields.Detours;
                    reader.BaseStream.Position += 4;
                    gsi = new GSICInfo();
                    for (int numFields = reader.ReadInt32(); numFields > 0; numFields--)
                    {
                        currentField = (T7ScriptObject.GSIFields)reader.ReadInt32();
                        switch (currentField)
                        {
                            case T7ScriptObject.GSIFields.Detours:
                                int numdetours = reader.ReadInt32();
                                for (int j = 0; j < numdetours; j++)
                                {
                                    T7ScriptObject.ScriptDetour detour = new T7ScriptObject.ScriptDetour();
                                    detour.Deserialize(reader);
                                    gsi.Detours.Add(detour);
                                }
                                break;
                        }
                    }
                    buffer = buffer.Skip((int)reader.BaseStream.Position).ToArray();
                }
                if (BitConverter.ToInt64(buffer, 0) != 0x1C000A0D43534780)
                {
                    return Error("Script is not a valid compiled script. Please use a script compiled for Black Ops III.");
                }
            }

            string file = "\\..\\GSIC\\";
            string execPath = Directory.GetCurrentDirectory();
            string path = Path.Combine(execPath + file);

            OriginalSourceChecksum = 590825551;
            BitConverter.GetBytes(OriginalSourceChecksum).CopyTo(buffer, 0x8);
            File.WriteAllBytes(path + "compiled.gscc", buffer);


            if (gsi != null)
            {
                // detours
                if (gsi.Detours.Count > 0)
                {
                    File.WriteAllBytes(path + "gsi.packdetour", gsi.PackDetours());
                    Console.WriteLine("Detour Count: " + gsi.Detours.Count);
                    Console.WriteLine("Please update detour count in inject.cpp");
                    Console.ReadKey();
                }


                return 0;
            }
            return 0;
        }


        private T8InjectCache InjectCache;

        private int InjectT8(string replacePath, byte[] buffer)
        {
            NoExcept(FreeT8Script);
            GSICInfoT8 gsi = null;
            if (BitConverter.ToInt64(buffer, 0) != 0x36000A0D43534780)
            {
                string preamble = Encoding.ASCII.GetString(buffer.Take(4).ToArray());
                if (preamble != "GSIC")
                {
                    return Error("Script is not a valid compiled script. Please use a script compiled for Black Ops III.");
                }
                using (MemoryStream ms = new MemoryStream(buffer))
                using (BinaryReader reader = new BinaryReader(ms))
                {
                    T7ScriptObject.GSIFields currentField = T7ScriptObject.GSIFields.Detours;
                    reader.BaseStream.Position += 4;
                    gsi = new GSICInfoT8();
                    for (int numFields = reader.ReadInt32(); numFields > 0; numFields--)
                    {
                        currentField = (T7ScriptObject.GSIFields)reader.ReadInt32();
                        switch (currentField)
                        {
                            case T7ScriptObject.GSIFields.Detours:
                                int numdetours = reader.ReadInt32();
                                for (int j = 0; j < numdetours; j++)
                                {
                                    T89ScriptObject.ScriptDetour detour = new T89ScriptObject.ScriptDetour();
                                    detour.Deserialize(reader);
                                    gsi.Detours.Add(detour);
                                }
                                break;
                        }
                    }
                    buffer = buffer.Skip((int)reader.BaseStream.Position).ToArray();
                }
                if (BitConverter.ToInt64(buffer, 0) != 0x36000A0D43534780)
                {
                    return Error("Script is not a valid compiled script. Please use a script compiled for Black Ops 4.");
                }
            }
            ProcessEx bo4 = "blackops4";
            if (bo4 is null)
            {
                return Error("No game process found for Black Ops 4.");
            }

            bo4.OpenHandle();
            OriginalPID = bo4.BaseProcess.Id;
            Console.WriteLine($"s_assetPool:ScriptParseTree => {bo4[0x912ABB0]}");
            var sptGlob = bo4.GetValue<ulong>(bo4[0x912ABB0]);
            var sptCount = bo4.GetValue<int>(bo4[0x912ABB0 + 0x14]);
            var SPTEntries = bo4.GetArray<T8SPT>(sptGlob, sptCount);
            replacePath = replacePath.ToLower().Trim().Replace("\\", "/");
            var surrogateScript = T8s64Hash(replacePath); // script we are hooking
            var targetScript = 0x124CECFF7280BE52; // script we are replacing
            InjectCache.hSurrogate = 0;
            InjectCache.hTarget = 0;

            for (int i = 0; i < SPTEntries.Length; i++)
            {
                var spt = SPTEntries[i];
                if (spt.ScriptName == surrogateScript)
                {
                    InjectCache.Surrogate = spt;
                    InjectCache.hSurrogate = sptGlob + (ulong)(i * Marshal.SizeOf(typeof(T8SPT)));
                }
                if (spt.ScriptName == targetScript)
                {
                    InjectCache.Target = spt;
                    InjectCache.hTarget = sptGlob + (ulong)(i * Marshal.SizeOf(typeof(T8SPT)));
                }
                if(InjectCache.hSurrogate && InjectCache.hTarget)
                {
                    break;
                }
            }

            try
            {
                if (!InjectCache.hSurrogate || !InjectCache.hTarget)
                {
                    return Error("Unable to identify critical injection information. Double check your script path, and try restarting the game. Make sure you are injecting in the pregame lobby.");
                }

                int includeOff = 0x58;
                int tableOff = 0x18;

                // patch include
                byte includeCount = bo4.GetValue<byte>(InjectCache.Surrogate.Buffer + includeOff);
                PointerEx includeTable = InjectCache.Surrogate.Buffer + bo4.GetValue<int>(InjectCache.Surrogate.Buffer + tableOff);
                for (int i = 0; i < includeCount; i++)
                {
                    if (bo4.GetValue<long>(includeTable + (i * 8)) == targetScript)
                    {
                        goto patchBuff;
                    }
                }
                bo4.SetValue(includeTable + (includeCount * 8), targetScript);
                bo4.SetValue(InjectCache.Surrogate.Buffer + includeOff, (byte)(includeCount + 1));

                patchBuff:
                bo4.GetBytes(InjectCache.Target.Buffer + 0x8, 8).CopyTo(buffer, 0x8); // crc32
                InjectCache.hBuffer = bo4.QuickAlloc(buffer.Length); // space
                bo4.SetBytes(InjectCache.hBuffer, buffer); // write to proc
                bo4.SetValue<long>(InjectCache.hTarget + 0x10, InjectCache.hBuffer); // buffer pointer redirect
                InjectCache.Pid = bo4.BaseProcess.Id;
                InjectCache.BufferSize = buffer.Length;
                InjectCache.IsInjected = true;

                try
                {
                    string exeFilePath = Assembly.GetExecutingAssembly().Location;
                    //var result = bo4.Call<long>(bo4.GetProcAddress(@"kernel32.dll", @"LoadLibraryA"), Path.Combine(Path.GetDirectoryName(exeFilePath), "t8cinternal.dll"));
                    //bo4.Refresh();

                    //if (result == 0)
                    //{
                    //    return 4;
                    //}

                    //bo4.Call<VOID>(bo4.GetProcAddress(@"t8cinternal.dll", @"RemoveDetours"));
                    //if (gsi != null)
                    //{
                    //    // detours
                    //    if (gsi.Detours.Count > 0)
                    //    {
                    //        bo4.Call<VOID>(bo4.GetProcAddress(@"t8cinternal.dll", @"RegisterDetours"), gsi.PackDetours(), gsi.Detours.Count, (long)InjectCache.hBuffer);
                    //    }
                    //}
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.ToString());
                    return 3;
                }
            }
            catch
            {
                return Error("Unknown error while injecting...");
            }
            finally
            {
                bo4.CloseHandle();
            }

            return 0;
        }

        private void FreeT8Script()
        {
            if (!InjectCache.IsInjected)
            {
                return;
            }

            ProcessEx bo4 = "blackops4";
            if (bo4 is null)
            {
                return;
            }

            if (bo4.BaseProcess.Id != InjectCache.Pid)
            {
                return;
            }

            bo4.OpenHandle();

            try
            {
                // free allocated space
                ProcessEx.VirtualFreeEx(bo4.Handle, InjectCache.hBuffer, (uint)InjectCache.BufferSize, (int)EnvironmentEx.FreeType.Release);

                // Patch spt struct
                bo4.SetStruct(InjectCache.hTarget, InjectCache.Target);

                // Reset hooked detours
                // bo4.Call<VOID>(bo4.GetProcAddress(@"t8cinternal.dll", @"RemoveDetours"));
            }
            finally
            {
                bo4.CloseHandle();
            }
        }

        private void FreeT7Script()
        {
            if (!llpModifiedSPTStruct) return;
            ProcessEx bo3 = "blackops3";
            if (bo3 == null) return;
            if (bo3.BaseProcess.Id != OriginalPID) return;
            bo3.OpenHandle();

            // free allocated space
            ProcessEx.VirtualFreeEx(bo3.Handle, InjectedScript.lpBuffer, (uint)InjectedBuffSize, (int)EnvironmentEx.FreeType.Release);

            // Patch spt struct
            InjectedScript.lpBuffer = llpOriginalBuffer;
            bo3.SetStruct(llpModifiedSPTStruct, InjectedScript);

            // Reset hooked detours
            bo3.Call<VOID>(bo3.GetProcAddress(@"t7cinternal.dll", @"RemoveDetours"));

            bo3.CloseHandle();
        }

        private struct T8InjectCache
        {
            public T8SPT Surrogate;
            public T8SPT Target;
            public PointerEx hSurrogate;
            public PointerEx hTarget;
            public PointerEx hBuffer;
            public int BufferSize;
            public int Pid;
            public bool IsInjected;
        }

        [StructLayout(LayoutKind.Sequential, Pack = 2)]
        struct T7SPT
        {
            public PointerEx llpName;     //00
            public int BuffSize;       //08
            public int Pad;
            public PointerEx lpBuffer;//10
        };

        [StructLayout(LayoutKind.Sequential, Pack = 1)]
        private struct T8SPT
        {
            public PointerEx ScriptName;
            public long pad0;
            public PointerEx Buffer;
            public int Size;
            public int Unk0;
        };

        private int cmd_Dump(string[] args)
        {
            return -1;
        }

        #endregion

        private static HashSet<string> HashIdentifierPrefixes = new HashSet<string>() { "script_" };
        public static ulong T8s64Hash(string input)
        {
            input = input.ToLower();

            //if input starts with func_, var_, or hash_, use the provided hash (if possible)
            foreach (string hashprefix in HashIdentifierPrefixes)
            {
                if (input[0] != hashprefix[0] || input.Length <= hashprefix.Length)
                    continue;
                if (!input.StartsWith(hashprefix))
                    continue;
                if (!ulong.TryParse(input.Substring(hashprefix.Length), NumberStyles.HexNumber, default, out ulong result))
                    break;
                return result;
            }

            return 0x7FFFFFFFFFFFFFFF & HashFNV1a(Encoding.ASCII.GetBytes(input));
        }

        uint Com_Hash(string Input, uint IV, uint XORKEY)
        {
            uint hash = IV;

            foreach (char c in Input)
                hash = (char.ToLower(c) ^ hash) * XORKEY;

            hash *= XORKEY;

            return hash;
        }

        public static ulong HashFNV1a(byte[] bytes, ulong fnv64Offset = 14695981039346656037, ulong fnv64Prime = 0x100000001b3)
        {
            ulong hash = fnv64Offset;

            for (var i = 0; i < bytes.Length; i++)
            {
                hash = hash ^ bytes[i];
                hash *= fnv64Prime;
            }

            return hash;
        }

        private ulong FS_HashFileName(string input, ulong hashSize)
        {
            return 0;
        }

        private static void SerializeMetaOps()
        {
        }

        private static Dictionary<byte, ScriptOpCode> XboxCodes = null;
        
    }
}

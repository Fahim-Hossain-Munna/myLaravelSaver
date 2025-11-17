### QR Code Generator 

```bash
    public function generateCode(Request $request)
    {
        $link = $request->link;
        $fileName = 'qr_' . Str::random(10) . '.png';
        $folder = '/qrcodes';

        // Ensure directory exists
        Storage::disk('public')->makeDirectory($folder);

        // Generate QR code as binary string
        $qrImage = QR::format('png')->size(300)->generate($link);

        // Create a temporary file
        $tempPath = tempnam(sys_get_temp_dir(), 'qr_') . '.png';
        file_put_contents($tempPath, $qrImage);

        // Create fake UploadedFile
        $uploadedFile = new UploadedFile(
            $tempPath,
            $fileName,
            'image/png',
            null,
            true
        );

        // Now use your existing method
        $media = MediaRepository::storeByRequest($uploadedFile, $folder, MediaEnum::IMAGE->value);

        // Clean up temp file (optional, Laravel may do it)
        @unlink($tempPath);

        return response()->json([
            'success' => true,
            'qr_image' => Storage::url($media->src), // or however you access it
        ]);
    }
```
